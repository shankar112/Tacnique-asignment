<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Employee Directory</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <h1>Employee Directory</h1>

  <div class="controls">
    <input type="text" id="search" placeholder="Search by name or email" oninput="applyFilters()">

    <select id="sort" onchange="sortBy(this.value)">
      <option value="">Sort by</option>
      <option value="firstName">First Name</option>
      <option value="department">Department</option>
    </select>

    <button onclick="showFilter()">Filter</button>
  </div>

  <div id="filter-section" class="hidden">
    <input type="text" id="filterFirstName" placeholder="Filter by First Name">
    <input type="text" id="filterDepartment" placeholder="Filter by Department">
    <input type="text" id="filterRole" placeholder="Filter by Role">
    <button onclick="applyFilters()">Apply Filters</button>
    <button onclick="resetFilters()">Reset</button>
  </div>

  <table id="employee-table">
    <thead>
      <tr>
        <th>Emp ID</th>
        <th>First</th>
        <th>Last</th>
        <th>Email</th>
        <th>Department</th>
        <th>Role</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <#assign employees = [
        {"id": "E001", "firstName": "Alice", "lastName": "Smith", "email": "alice@example.com", "department": "HR", "role": "Manager"},
        {"id": "E002", "firstName": "Bob", "lastName": "Jones", "email": "bob@example.com", "department": "Engineering", "role": "Developer"},
        {"id": "E003", "firstName": "Carol", "lastName": "Lee", "email": "carol@example.com", "department": "Marketing", "role": "Executive"}
      ]>
      <#list employees as emp>
        <tr data-id="${emp.id}">
          <td>${emp.id}</td>
          <td>${emp.firstName}</td>
          <td>${emp.lastName}</td>
          <td>${emp.email}</td>
          <td>${emp.department}</td>
          <td>${emp.role}</td>
          <td>
            <button onclick="editEmployee('${emp.id}')">Edit</button>
            <button onclick="deleteEmployee('${emp.id}')">Delete</button>
          </td>
        </tr>
      </#list>
    </tbody>
  </table>

  <div id="pagination">
    <button onclick="goToPage(1)">1</button>
    <button onclick="goToPage(2)">2</button>
  </div>

  <script src="app.js"></script>
</body>
</html>
