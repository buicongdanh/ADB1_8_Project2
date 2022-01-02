using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Login.NhanSu
{
    public partial class Menu : Form
    {
        private string ma;

        public Menu()
        {
            InitializeComponent();
        }

        public Menu(string ma)
        {
            this.ma = ma;
            InitializeComponent();
        }

        private void Menu_Load(object sender, EventArgs e)
        {

        }
    }
}
