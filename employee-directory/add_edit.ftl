<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add / Edit Employee</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1 id="form-title">Add Employee</h1>

  <form id="emp-form" onsubmit="submitForm(event)">
    <input type="hidden" id="empId" />

    <label>First Name:</label>
    <input id="firstName" required />

    <label>Last Name:</label>
    <input id="lastName" required />

    <label>Email:</label>
    <input id="email" required type="email" />

    <label>Department:</label>
    <input id="department" required />

    <label>Role:</label>
    <input id="role" required />

    <button type="submit">Save</button>
    <button type="button" onclick="goBack()">Cancel</button>
  </form>

  <script>
    const urlParams = new URLSearchParams(window.location.search);
    const empId = urlParams.get("id");

    if (empId) {
      document.getElementById("form-title").textContent = "Edit Employee";
      const existing = localStorage.getItem("employees");
      if (existing) {
        const employees = JSON.parse(existing);
        const emp = employees.find(e => e.id === empId);
        if (emp) {
          document.getElementById("empId").value = emp.id;
          document.getElementById("firstName").value = emp.firstName;
          document.getElementById("lastName").value = emp.lastName;
          document.getElementById("email").value = emp.email;
          document.getElementById("department").value = emp.department;
          document.getElementById("role").value = emp.role;
        }
      }
    }

    function submitForm(e) {
      e.preventDefault();

      const id = document.getElementById("empId").value || `E${Math.floor(Math.random() * 9000) + 1000}`;
      const firstName = document.getElementById("firstName").value.trim();
      const lastName = document.getElementById("lastName").value.trim();
      const email = document.getElementById("email").value.trim();
      const department = document.getElementById("department").value.trim();
      const role = document.getElementById("role").value.trim();

      if (!email.match(/^[^@]+@[^@]+\.[^@]+$/)) {
        alert("Invalid email format");
        return;
      }

      let employees = JSON.parse(localStorage.getItem("employees")) || [];
      const existingIndex = employees.findIndex(e => e.id === id);

      const newEmp = { id, firstName, lastName, email, department, role };

      if (existingIndex >= 0) {
        employees[existingIndex] = newEmp;
      } else {
        employees.push(newEmp);
      }

      localStorage.setItem("employees", JSON.stringify(employees));
      window.location.href = "index.ftl";
    }

    function goBack() {
      window.location.href = "index.ftl";
    }
  </script>
</body>
</html>
