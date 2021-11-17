using DapperCrudMVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DapperCrudMVC.Controllers
{
    public class EmployeesController : Controller
    {
        private EmployeesRepository repository;

        public EmployeesController()
        {
            repository = new EmployeesRepository();
        }


        // GET: Employees
        public ActionResult Index(RequestModel request)
        {
            if (request.OrderBy == null)
            {
                request = new RequestModel
                {
                    Search = request.Search,
                    OrderBy = "name",
                    IsDescending = false
                };
            }
            ViewBag.Request = request;
            return View(repository.GetAll(request));
           
        }

        // GET: Employees/Details/5
        public ActionResult Details(int id)
        {
            return View(repository.Get(id));
        }

        // GET: Employees/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Employees/Create
        [HttpPost]
        public ActionResult Create(Employees employee, bool editAfterSaving = false)
        {
            if (ModelState.IsValid)
            {
                var lastInsertedId = repository.Create(employee);
                if (lastInsertedId > 0)
                {
                    TempData["Message"] = "Record added successfully";
                }
                else
                {
                    TempData["Error"] = "Failed to add record";
                }
                if (editAfterSaving)
                {
                    return RedirectToAction("Edit", new { Id = lastInsertedId });
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            return View();
        }

        // GET: Employees/Edit/5
        public ActionResult Edit(int Id)
        {
            return View(repository.Get(Id));
        }

        // POST: Employees/Edit/5
        [HttpPost]
        public ActionResult Edit(Employees employee)
        {
            if (ModelState.IsValid)
            {
                var recordAffected = repository.Update(employee);
                if (recordAffected > 0)
                {
                    TempData["Message"] = "Record updated successfully";
                }
                else
                {
                    TempData["Error"] = "Failed to update record";
                }
                return RedirectToAction("Index");
            }
            return View();
        }

        // GET: Employees/Delete/5
        public ActionResult Delete(int id)
        {
            return View(repository.Get(id));
        }

        // POST: Employees/Delete/5
        [HttpPost]
        public ActionResult Delete(Employees employee)
        {
            var recordAffected = repository.Delete(employee.Id);
            if (recordAffected > 0)
            {
                TempData["Message"] = "Record deleted successfully";
            }
            else
            {
                TempData["Error"] = "Failed to delete record";
            }
            return RedirectToAction("Index");
        }
    }
}
