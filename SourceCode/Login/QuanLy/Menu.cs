using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Login.QuanLy
{
    public partial class Menu : Form
    {
        private string MaQL;

        public Menu()
        {
            InitializeComponent();
        }

        public Menu(string ma)
        {
            this.MaQL = ma;
            InitializeComponent();
        }

        private void Menu_Load(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form frmQL_XHS = new QuanLy.Xem_HieuSuat(MaQL);
            frmQL_XHS.ShowDialog();
            this.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form frmQL_TKSP = new QuanLy.ThongKe_SLSP(MaQL);
            frmQL_TKSP.ShowDialog();
            this.Show();
        }
    }
}
