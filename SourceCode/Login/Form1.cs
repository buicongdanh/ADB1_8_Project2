using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace Login
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
        SqlConnection cnn = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog = CUA_HANG_HOA;Integrated Security = True");
        private void button1_Click(object sender, EventArgs e)
        {
            var username = textBox1.Text;
            var password = textBox2.Text;
            string account_type = "";
            string ma = "";
            try
            {
                string sql =
                    $"EXEC dang_nhap " +
                    $"@tai_khoan = {username}, " +
                    $"@mat_khau = {password}, " +
                    $"@loai_tk = @loai_tk OUTPUT, " +
                    $"@ma = @ma OUTPUT " +
                    $"SELECT @loai_tk, @ma";
                cnn.Open();
                SqlCommand com = new SqlCommand(sql, cnn);
                com.Parameters.Add("@loai_tk", SqlDbType.Char, 2).Direction = ParameterDirection.Output;
                com.Parameters.Add("@ma", SqlDbType.Char, 10).Direction = ParameterDirection.Output;
                com.ExecuteNonQuery();

                account_type = (string)com.Parameters["@loai_tk"].Value;
                ma = (string)com.Parameters["@ma"].Value;
                string result = $"Loại tài khoản: {account_type}, Mã = {ma}";
                MessageBox.Show(result, "Kết quả");
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
