using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace DapperCrudMVC.Models
{
    public class Employees
    {
        public int Id { get; set; }
        [Required]
        [MaxLength(300)]
        public string Name { get; set; }
        [Required]
        [MinLength(4)]
        [MaxLength(300)]
        public int Salary { get; set; }
        [Required]
        [Display(Name = "Mobile Number")]
        public int MobileNumber { get; set; }
        [Required]
        [MaxLength(300)]
        [Display(Name = "Address")]
        public string Address { get; set; }
       
   }

}