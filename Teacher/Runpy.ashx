<%@ WebHandler Language="C#" Class="Runpy" %>

using System;
using System.Web;
using System.IO;

public class Runpy : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        if (context.Request.QueryString["file"] != null)
        {
            string Pyfile = context.Request.QueryString["file"].ToString();
            string Pypath = context.Server.MapPath(context.Server.UrlDecode(Pyfile));            
            if (File.Exists(Pypath))
            {
                string msg = "File is exist,ok!";
                msg= runpython(Pypath);
                if (string.IsNullOrEmpty(msg))
                    msg = "服务器上未安装python或程序无输出信息";
                context.Response.Write(msg);                
            }
            else
                context.Response.Write("Not find the file!");
        }
        else
            context.Response.Write("wrong querystring!");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    private string runpython(string filepath) {
        string pyPath = "python";
        System.Diagnostics.ProcessStartInfo procStartInfo = new System.Diagnostics.ProcessStartInfo(pyPath, filepath);
        procStartInfo.RedirectStandardOutput = true;
        procStartInfo.UseShellExecute = false;
        procStartInfo.CreateNoWindow = true;
        using (System.Diagnostics.Process process = System.Diagnostics.Process.Start(procStartInfo))
        {
            using (StreamReader reader = process.StandardOutput)
            {
                string result = reader.ReadToEnd();
                return result;
            }
        }
    }

}