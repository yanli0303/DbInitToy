using System;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text;
using System.Xml;

namespace DbInitToy
{
    class Program
    {
        const string ErrorXmlCannotLoad = "The specified xml setting file cannot be loaded";
        const string ErrorXmlNotValid = "The specifiled xml setting file is not an valid DbInitToy setting file";

        static void ShowColorfulMsg(string msg, ConsoleColor foreColor, ConsoleColor bgColor)
        {
            ConsoleColor fcolor = Console.ForegroundColor;
            ConsoleColor bcolor = Console.BackgroundColor;

            Console.ForegroundColor = foreColor;
            Console.BackgroundColor = bgColor;

            Console.WriteLine(msg);

            Console.ForegroundColor = fcolor;
            Console.BackgroundColor = bcolor;
        }
        static void ShowColorfulMsg(string msg, ConsoleColor foreColor)
        {
            ConsoleColor old = Console.ForegroundColor;
            Console.ForegroundColor = foreColor;
            Console.WriteLine(msg);
            Console.ForegroundColor = old;
        }
        static void ShowError(string msg)
        {
            ShowColorfulMsg(msg, ConsoleColor.Red);
        }
        static void ShowSuccess(string msg)
        {
            ShowColorfulMsg(msg, ConsoleColor.Green);
        }
        static void ShowNotValidError(string custMsg, string innerMsg, string file)
        {
            string format = "Error: {0}{1}{2}.{1}File: {3}";
            ShowError(string.Format(format, innerMsg, Environment.NewLine, custMsg, file));
        }
        static void ParseSettingFile(string file, out string conn, out List<SqlScriptFileInfo> list)
        {
            conn = null;
            list = null;

            Console.Write("Parsing xml setting file: ");
            ShowColorfulMsg(file, ConsoleColor.Cyan);

            if (string.IsNullOrEmpty(file) || !Path.IsPathRooted(file))
            {
                ShowError("Invalid file name!");
                return;
            }

            XmlDocument doc = new XmlDocument();
            try
            {
                doc.Load(file);
            }
            catch (Exception ex)
            {
                ShowNotValidError(ErrorXmlCannotLoad, ex.Message, file);
            }

            XmlElement root = doc.DocumentElement;

            if (null == root || "Script" != root.Name || null == root.Attributes["ConnectionString"])
            {
                ShowNotValidError(ErrorXmlNotValid, "Could not find the specified attributes.", file);
                return;
            }

            conn = root.Attributes["ConnectionString"].Value;
            list = new List<SqlScriptFileInfo>(root.ChildNodes.Count);

            foreach (XmlNode node in root.ChildNodes)
            {
                try
                {
                    list.Add(ParseXmlNode(node));
                }
                catch (Exception ex)
                {
                    ShowNotValidError(ErrorXmlNotValid, ex.Message, file);
                }
            }

            ShowSuccess("The file is valid." + Environment.NewLine);
        }
        static SqlScriptFileInfo ParseXmlNode(XmlNode node)
        {
            if ("File" != node.Name || null == node.Attributes["path"])
                return null;

            XmlAttribute att = node.Attributes["path"];
            return new SqlScriptFileInfo(att.Value);
        }
        static void Execute(string[] xmlFiles)
        {
            foreach (string file in xmlFiles)
            {
                List<SqlScriptFileInfo> list;
                string connstr;

                ParseSettingFile(file, out connstr, out list);

                if (null == connstr || null == list || 0 == list.Count)
                    return;

                using (SqlConnection conn = new SqlConnection(connstr))
                {
                    Console.WriteLine("Opening database connection...");
                    ShowColorfulMsg("\tConnection string: " + connstr, ConsoleColor.Cyan);
                    try
                    {
                        conn.Open();
                        ShowSuccess("Connection opened successfully.");
                    }
                    catch (Exception ex)
                    {
                        ShowError("Error: " + ex.Message);
                        continue;
                    }

                    Console.WriteLine();
                    foreach (SqlScriptFileInfo info in list)
                    {
                        if (null == info)
                            continue;

                        using (SqlCommand cmd = new SqlCommand(info.SqlString, conn))
                        {
                            Console.Write("Executing {0}... ", info.FilePath);

                            try
                            {
                                int rowsAffected = cmd.ExecuteNonQuery();
                                ShowSuccess("Success.");
                            }
                            catch (Exception ex)
                            {
                                ShowError(" Error: " + ex.Message);
                                continue;
                            }
                        }
                    }

                    Console.WriteLine("{0}Execution complete.{0}", Environment.NewLine);
                }
            }
        }

        //DbInitToy xmlfile.xml
        static void Main(string[] args)
        {
            ConsoleColor fcolor = Console.ForegroundColor;
            ConsoleColor bcolor = Console.BackgroundColor;

            string[] xmlFile = GetXmlSettingFile(args);

            ListFiles(xmlFile);

            if (Console.ReadKey().Key == ConsoleKey.Y)
            {
                Console.WriteLine();
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;

                Execute(xmlFile);
            }
            
            Console.ForegroundColor = fcolor;
            Console.BackgroundColor = bcolor;
        }

        static string[] GetXmlSettingFile(string[] args)
        {
            string[] xmlFile = 0 == args.Length ? Directory.GetFiles(Environment.CurrentDirectory, "*.xml") : args;

            if (0 == xmlFile.Length)
            {
                ShowError(@"Could not find the xml setting file in this directory.
Either you can specify which xml setting file to use, e.g. 'DbInitToy xmlfile.xml, xmlfile2.xml',
or put the xml setting files in the directory.");
                Environment.Exit(-1);
            }

            return xmlFile;
        }
        static void ListFiles(string[] xmlFile)
        {
            if (1 == xmlFile.Length)
            {
                Console.WriteLine("Found file:{0}\t{1}", Environment.NewLine, xmlFile[0]);
            }
            else
            {
                Console.WriteLine("Found files: ");
                for (int i = 0; i < xmlFile.Length; i++)
                {
                    Console.WriteLine("\t{0}. {1}", i, xmlFile[i]);
                }
            }

            Console.WriteLine();
            Console.Write("Execute? (y/n): ");
        }
    }
}
