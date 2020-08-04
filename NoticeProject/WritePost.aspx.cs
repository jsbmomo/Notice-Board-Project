using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using NoticeProject.DBConnection;

namespace NoticeProject
{
    public partial class WritePost : System.Web.UI.Page
    {
        private static string updateContents_index = "";// Post로 수정될 게시물의 인덱스를 받음 

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Login_UserID_lbl.Text = Session["LoginUsers"].ToString();
            }

            Written.Value = Session["LoginUsers"].ToString();

            // 만약 게시물을 새로 생성하는 것이 아니라 수정하는 것이라면(받은 값이 있다면),
            // Post로 받아온 내용(ID, Index)을 sql문에 작성 후, 해당 내용을 화면(TextBox)에 표시
            //HttpContext context = HttpContext.Current;
            //updateContents_index = context.Items["index"].ToString();
            //updateContents_userID = context.Items["Id"].ToString();

            string board_id;
            try
            {
                board_id = Request.QueryString["board_id"].ToString(); // get으로 메인화면에서 게시물의 주소를 가져옴 
            }
            catch(Exception ex)
            {
                board_id = "";
            }

            // !IsPostBack를 하지 않을 경우, 버튼을 누르는 등 이벤트가 발생될 때마다
            // DB에서 새롭게 데이터를 불러오게 되며, 이를 통해 수정한 데이터를 저장하는 것이 아니라
            // 기존의 데이터를 다시 저장하는 과정을 거치게 된다.
            if (!IsPostBack)
            {
                // 아래 부분은 기존의 게시물 내용을 보여줄 때, 사용되는 부분이다.
                if (!string.IsNullOrEmpty(board_id))
                {
                    CreateBoardBtn.Visible = false;
                    UpdateContentsBtn.Visible = true;
                    updateContents_index = board_id;

                    string sql = @"SELECT
                                        [header],
                                        [input_info]
                                   FROM dbo.Board
                                   WHERE
                                        [number] = @1
                                   AND
                                        [user_id] = @2";
                    MSConnection connection = new MSConnection();
                    DataTable datatable = connection.GetDataTable(sql, board_id, Written.Value);
                    connection.CloseDB();

                    string header = ""; // DB에서 header의 내용을 저장
                    string contents = ""; // DB에서 input_info의 내용을 저장
                    header = datatable.Rows[0]["header"].ToString(); // 가져온 데이터에서 "header"부분만 따로 저장 
                    contents = datatable.Rows[0]["input_info"].ToString(); // 가져온 데이터에서 "input_info" 부분만 따로 저장 
                    WriteHead.Value = header;
                    WriteContent.Text = contents;

                }
                else
                {
                    CreateBoardBtn.Visible = true;
                    UpdateContentsBtn.Visible = false;
                }
            }
        }


        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Remove("LoginUsers");
            Session.Remove("authority");
            Response.Redirect("~/Default.aspx");
        }


        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            string previousPage = Request.QueryString["previousPage"].ToString();

            //"?previousPage=Contents"
            if (previousPage == "Contents")
            {
                Response.Redirect("~/Contents.aspx?board_id=" + updateContents_index);
            }
            else
            {
                Response.Redirect("~/NoticePage.aspx");
            }
            //Response.Redirect(Request.QueryString["~/NoticePage.aspx"]);
        }


        // 만약 새로 게시물을 생성할 경우.
        protected void CreateBoardBtn_Click(object sender, EventArgs e)
        {
            if (FileUpLoader.HasFile)
            {
                FileUpLoad_Excute();
            }
            else
            {
                BoardUpdate_Excute();
            }
            
            // 만약 업로드된 파일이 있다면 
            ClientScript.RegisterStartupScript(typeof(Page), "alert",
                "<script> alert('게시물이 작성되었습니다.'); location.href='NoticePage.aspx'; </script>");
        }


        // 만약 기존의 내용을 수정할 경우 
        protected void UpdateContentsBtn_Click(object sender, EventArgs e)
        {
            string sql = @"UPDATE Board SET 
                                [input_info] = @1,
                                [header] = @2
                           WHERE
                                [number] = @3
                           AND
                                [user_id] = @4";
            List<object> param = new List<object>();
            param.Add(WriteContent.Text);
            param.Add(WriteHead.Value);
            param.Add(updateContents_index);
            param.Add(Written.Value);

            MSConnection connection = new MSConnection();
            connection.ExcuteQuery(sql, param);
            connection.CloseDB();

            ClientScript.RegisterStartupScript(typeof(Page), "alert",
                "<script> alert('정상적으로 변경되었습니다.'); </script>");
        }


        // 만약 사용자가 업로드 하려는 파일이 있을 경우 
        void FileUpLoad_Excute()
        {
            string filename = Path.GetFileName(FileUpLoader.PostedFile.FileName);
            string contentType = FileUpLoader.PostedFile.ContentType;

            Stream fs = FileUpLoader.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = br.ReadBytes((Int32)fs.Length);

            string sql = @"INSERT INTO Board(
                                [user_id],
                                [header],
                                [input_info],
                                [fileName],
                                [imgsize],
                                [fileType]
                            )
                           VALUES(
                                @1,
                                @2,
                                @3,
                                @4,
                                @5,
                                @6
                            )";
            List<object> param = new List<object>();
            param.Add(Written.Value);
            param.Add(WriteHead.Value);
            param.Add(WriteContent.Text);
            param.Add(filename);
            param.Add(bytes);
            param.Add(contentType);

            // cmd.Parameters.AddWithValue("@FileExist", contentType); // 파일의 존재여부를 판단하는 bit형 
            MSConnection connection = new MSConnection();
            connection.ExcuteQuery(sql, param);
            connection.CloseDB();
        }


        // 파일 없이 게시판을 업로드 하는 경우 
        void BoardUpdate_Excute()
        {
            string sql = @"INSERT INTO Board(
                                [user_id],
                                [header],
                                [input_info]
                            )
                           VALUES(
                                @1,
                                @2,
                                @3
                            )";
            List<object> param = new List<object>();
            param.Add(Written.Value);
            param.Add(WriteHead.Value);
            param.Add(WriteContent.Text);

            MSConnection connection = new MSConnection();
            connection.ExcuteQuery(sql, param);
            connection.CloseDB();
        }
    }
}
   