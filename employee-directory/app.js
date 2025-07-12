let employees = Array.from(document.querySelectorAll("tr[data-id]")).map(row => ({
  id: row.dataset.id,
  firstName: row.children[1].innerText,
  lastName: row.children[2].innerText,
  email: row.children[3].innerText,
  department: row.children[4].innerText,
  role: row.children[5].innerText
}));

let currentPage = 1;
const pageSize = 10;

const tbody = document.querySelector("#employee-table tbody");

function render(data) {
  tbody.innerHTML = "";
  const paginated = paginate(data, pageSize, currentPage);

  paginated.forEach(emp => {
    const row = document.createElement("tr");
    row.setAttribute("data-id", emp.id);
    row.innerHTML = `
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
    `;
    tbody.appendChild(row);
  });
}

function applyFilters() {
  const searchText = document.getElementById("search").value.toLowerCase();
  const filterFirst = document.getElementById("filterFirstName").value.toLowerCase();
  const filterDept = document.getElementById("filterDepartment").value.toLowerCase();
  const filterRole = document.getElementById("filterRole").value.toLowerCase();

  let filtered = employees.filter(emp => {
    const fullName = (emp.firstName + " " + emp.lastName).toLowerCase();
    return (
      (!searchText || fullName.includes(searchText) || emp.email.toLowerCase().includes(searchText)) &&
      (!filterFirst || emp.firstName.toLowerCase().includes(filterFirst)) &&
      (!filterDept || emp.department.toLowerCase().includes(filterDept)) &&
      (!filterRole || emp.role.toLowerCase().includes(filterRole))
    );
  });

  render(filtered);
}

function sortBy(field) {
  employees.sort((a, b) => a[field].localeCompare(b[field]));
  render(employees);
}

function paginate(data, size, page) {
  const start = (page - 1) * size;
  return data.slice(start, start + size);
}

function goToPage(pageNum) {
  currentPage = pageNum;
  applyFilters(); 
}

function showFilter() {
  document.getElementById("filter-section").classList.toggle("hidden");
}

function resetFilters() {
  document.getElementById("search").value = "";
  document.getElementById("filterFirstName").value = "";
  document.getElementById("filterDepartment").value = "";
  document.getElementById("filterRole").value = "";
  render(employees);
}

function deleteEmployee(id) {
  if (confirm("Are you sure you want to delete this employee?")) {
    employees = employees.filter(e => e.id !== id);
    applyFilters();
  }
}

function editEmployee(id) {
  window.location.href = `add_edit.ftl?id=${id}`;
}

render(employees);
