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
namespace Login.QuanLy
{
    public partial class Xem_HieuSuat : Form
    {
        private string MaQL;
        SqlConnection cnn = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog = CUA_HANG_HOA;Integrated Security = True");
        public Xem_HieuSuat()
        {
            InitializeComponent();
        }
        public Xem_HieuSuat(string MaQL)
        {
            this.MaQL = MaQL;
            InitializeComponent();
        }
        private void Xem_HieuSuat_Load(object sender, EventArgs e)
        {
            try
            {
                cnn.Open();
                string sql = $"EXCE xem_hieu_suat_nv @Ma_QL = {MaQL}";
                SqlCommand com = new SqlCommand(sql, cnn);
                com.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Caution");
            }
            finally
            {
                cnn.Close();
            }
        }
    }
}
