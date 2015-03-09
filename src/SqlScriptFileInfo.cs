using System;
using System.IO;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Text.RegularExpressions;

namespace DbInitToy
{
    public class SqlScriptFileInfo
    {
        private string _FilePath;
        public string FilePath
        {
            get { return _FilePath; }
            set
            {
                _SqlString = null;
                _FilePath = value;
            }
        }

        private string _SqlString;
        public string SqlString
        {
            get
            {
                if (null == _SqlString)
                    _SqlString = ReadAllSql();

                return _SqlString;
            }
        }

        public SqlScriptFileInfo(string filePath)
        {
            _FilePath = filePath;
            _SqlString = ReadAllSql();
        }

        private static string FormatSql(string sql)
        {
            if (null == sql)
                throw new ArgumentNullException("sql");

            if (string.Empty == sql)
                return sql;

            //Replace go or with string.Empty.
            Regex go = new Regex(@"\bgo\b", 
                RegexOptions.Multiline 
                | RegexOptions.Compiled 
                | RegexOptions.CultureInvariant 
                | RegexOptions.IgnoreCase );

            return go.Replace(sql, string.Empty);
        }

        public string ReadAllSql()
        {
            string sql = File.ReadAllText(FilePath);
            return FormatSql(sql);
        }
    }
}
