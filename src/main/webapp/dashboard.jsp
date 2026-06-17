<%@ page import="model.User" %>
<%@ page import="model.Expense" %>
<%@ page import="dao.ExpenseDao" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Income" %>
<%@ page import="dao.IncomeDao" %>

<%

    String filter =
            request.getParameter("filter");

    if(filter == null){

        filter = "daily";
    }





%>

<%
    User user = (User) session.getAttribute("user");

    if(user == null){
        response.sendRedirect("index.jsp");
        return;
    }

    ExpenseDao dao = new ExpenseDao();

    List<Expense> expenses =
            dao.getExpensesByUser(user);

    double totalExpense = 0;

    for(Expense e : expenses){
        totalExpense += e.getAmount();
    }

    IncomeDao incomeDao = new IncomeDao();

    List<Income> incomes =
            incomeDao.getIncomeByUser(user);

    double totalIncome = 0;

    for(Income i : incomes){
        totalIncome += i.getAmount();
    }

    double balance =
            totalIncome - totalExpense;






    double spendingLimit = 5000;

    double remainingLimit =
            spendingLimit - totalExpense;

    double food = 0;
    double travel = 0;
    double shopping = 0;
    double bills = 0;
    double entertainment = 0;

    for(Expense ex : expenses){

        String cat = ex.getCategory().toLowerCase();

        if(cat.contains("food"))
            food += ex.getAmount();

        else if(cat.contains("travel"))
            travel += ex.getAmount();

        else if(cat.contains("shopping"))
            shopping += ex.getAmount();

        else if(cat.contains("bill"))
            bills += ex.getAmount();

        else
            entertainment += ex.getAmount();
    }
%>





<!DOCTYPE html>
<html>
<head>

    <title>Expense Tracker</title>

    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/css/dashboard.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<div class="container">

    <!-- TOPBAR -->
    <div class="topbar">

        <div class="top-left">

            <h1>
                Good Morning,
                <%= user.getName() %>!
            </h1>

        </div>

        <div class="top-right">

            <form method="get">

                <select name="chartFilter"
                        onchange="this.form.submit()">

                    <option value="daily">

                        Daily

                    </option>

                    <option value="monthly">

                        Monthly

                    </option>

                    <option value="yearly">

                        Yearly

                    </option>

                </select>

            </form>

            <%

                java.time.LocalDate today =
                        java.time.LocalDate.now();

            %>

            <div class="date-box">

                <%= today %>

            </div>

            <button class="export-btn">
                <a href="exportCsv">
                    Export CSV
                </a>
            </button>

            <a href="logout" class="logout-btn">
                Logout
            </a>

        </div>

    </div>

    <!-- FIRST ROW -->
    <div class="cards-grid">

        <!-- INCOME -->
        <div class="white-card">

            <div class="card-top-row">

                <h3>Monthly Income</h3>

                <i class="fa fa-ellipsis"></i>

            </div>

            <h1>
                $<%= totalIncome %>
            </h1>

            <p class="green-text">
                Total Income Added
            </p>

        </div>

        <!-- EXPENSE -->
        <div class="white-card">

            <div class="card-top-row">

                <h3>Monthly Expenses</h3>

                <i class="fa fa-ellipsis"></i>

            </div>

            <h1>
                $<%= totalExpense %>.00
            </h1>

            <p class="green-text">
                Total Expenses Tracked
            </p>

        </div>



        <!-- CARD -->
        <div class="bank-card">

            <div class="card-top-row">

                <h3>My Card</h3>

                <i class="fa fa-ellipsis"></i>

            </div>

            <p class="small-text">
                Linked to your primary wallet
            </p>

            <div class="chip"></div>

            <div class="card-number">
                5435 2735 0037 0015
            </div>

            <p class="card-name">
                <%= user.getName() %>
            </p>

            <div class="spending">

                <p>Spending Limit</p>

                <h2>$<%= remainingLimit %></h2>

                <div class="progress-bar">

                    <div class="progress"></div>

                </div>

            </div>

        </div>

    </div>

    <!-- SECOND ROW -->
    <div class="middle-grid">

        <!-- OVERVIEW -->
        <!-- OVERVIEW -->
        <div class="overview-card">
            <div class="overview-header">
                <h3>Overview</h3>

                <div class="overview-actions">
                    <select id="chartFilter">
                        <option>Daily</option>
                        <option>Monthly</option>
                        <option selected>Yearly</option>
                    </select>

                    <button class="filter-btn">
                        <i class="fa fa-filter"></i> Filter
                    </button>
                </div>
            </div>

            <div class="chart-container">
                <canvas id="expenseChart"></canvas>
            </div>
        </div>

        <!-- ANALYTICS -->
        <!-- ALL EXPENSES -->
        <div class="expenses-summary-card">

            <div class="card-top">
                <h3>All Expenses</h3>
                <i class="fa fa-ellipsis-h"></i>
            </div>

            <p class="summary-text">
                Spending breakdown by category
            </p>

            <h1>$<%= totalExpense %></h1>

            <div class="stats-row">

                <div>
                    <span>Daily</span>
                    <h4>$<%= String.format("%.2f", totalExpense/30) %></h4>
                </div>

                <div>
                    <span>Weekly</span>
                    <h4>$<%= String.format("%.2f", totalExpense/4) %></h4>
                </div>

                <div>
                    <span>Monthly</span>
                    <h4>$<%= String.format("%.2f", totalExpense) %></h4>
                </div>

            </div>

            <div class="progress-line"></div>

            <div class="category-list">

                <div class="expense-item">
                    <div>
                        <span class="dot orange"></span>
                        Food & Health
                    </div>

                    <span>$<%= food %></span>
                </div>

                <div class="expense-item">
                    <div>
                        <span class="dot yellow"></span>
                        Travel
                    </div>

                    <span>$<%= travel %></span>
                </div>

                <div class="expense-item">
                    <div>
                        <span class="dot gold"></span>
                        Shopping
                    </div>

                    <span>$<%= shopping %></span>
                </div>

                <div class="expense-item">
                    <div>
                        <span class="dot green"></span>
                        Bills
                    </div>

                    <span>$<%= bills %></span>
                </div>

                <div class="expense-item">
                    <div>
                        <span class="dot orange"></span>
                        Entertainment
                    </div>

                    <span>$<%= entertainment %></span>
                </div>

            </div>

        </div>
    </div>



    <!-- TRANSACTIONS -->
    <div class="transactions-card">

        <div class="transaction-top">

            <h3>Recent Transactions</h3>

            <div class="transaction-buttons">

                <button>
                    <i class="fa fa-sort"></i>
                    Short
                </button>

                <button>
                    <i class="fa fa-filter"></i>
                    Filter
                </button>

            </div>

        </div>

        <table>

            <tr>
                <th>ID</th>
                <th>Category</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Action</th>

            </tr>

            <%
                for(Expense e : expenses){
            %>

            <tr>

                <td><%= e.getId() %></td>

                <td><%= e.getTitle() %></td>

                <td>$<%= e.getAmount() %></td>

                <td><%= e.getCategory() %></td>

                <td style="color:green;">
                    Completed
                </td>

                <td>
                    <span class="completed">
                        Completed
                    </span>
                </td>

                <td>

                    <a class="delete-btn"
                       href="deleteExpense?id=<%= e.getId() %>">

                        Delete

                    </a>

                </td>

            </tr>

            <%
                }
            %>

        </table>

    </div>

    <!-- INCOME HISTORY -->

    <div class="transactions-card">

        <div class="transaction-top">

            <h3>Income History</h3>

        </div>

        <table>

            <tr>
                <th>ID</th>
                <th>Source</th>
                <th>Amount</th>
                <th>Action</th>
            </tr>

            <%
                for(Income income : incomes){
            %>

            <tr>

                <td>
                    <%= income.getId() %>
                </td>

                <td>
                    <%= income.getSource() %>
                </td>

                <td>
                    $<%= income.getAmount() %>
                </td>

                <td>

                    <a class="delete-btn"
                       href="deleteIncome?id=<%= income.getId() %>">

                        Delete

                    </a>

                </td>

            </tr>

            <%
                }
            %>

        </table>

    </div>

</div>

<!-- FLOATING BUTTONS -->

<div class="floating-buttons">

    <button class="plus-btn"
            onclick="openIncomeModal()">

        +

    </button>

    <button class="minus-btn"
            onclick="openExpenseModal()">

        -

    </button>

</div>

<!-- EXPENSE MODAL -->

<div class="modal"
     id="expenseModal">

    <div class="modal-content">

        <span class="close"
              onclick="closeExpenseModal()">

            &times;

        </span>

        <h2>Add Expense</h2>

        <form action="addExpense"
              method="post">

            <input type="text"
                   name="title"
                   placeholder="Expense Title"
                   required>

            <select name="category" required>

                <option value="">
                    Select Category
                </option>

                <option value="Food">
                    Food
                </option>

                <option value="Travel">
                    Travel
                </option>

                <option value="Shopping">
                    Shopping
                </option>

                <option value="Bills">
                    Bills
                </option>

                <option value="Entertainment">
                    Entertainment
                </option>

            </select>

            <input type="number"
                   step="0.01"
                   name="amount"
                   placeholder="Amount"
                   required>

            <button type="submit">
                Save Expense
            </button>

        </form>

    </div>

</div>

<!-- INCOME MODAL -->

<div class="modal"
     id="incomeModal">

    <div class="modal-content">

        <span class="close"
              onclick="closeIncomeModal()">

            &times;

        </span>

        <h2>Add Income</h2>

        <form action="addIncome" method="post">

            <input type="text"
                   name="source"
                   placeholder="Income Source"
                   required>

            <input type="number"
                   step="0.01"
                   name="amount"
                   placeholder="Amount"
                   required>

            <button type="submit">
                Save Income
            </button>

        </form>

    </div>

</div>



<script>
    const expenseChart = document.getElementById('expenseChart');

    new Chart(expenseChart, {
        type: 'bar',

        data: {
            labels: [
                'Food',
                'Travel',
                'Shopping',
                'Bills',
                'Entertainment'
            ],

            datasets: [{
                label: 'Expenses',

                data: [
                    <%= food %>,
                    <%= travel %>,
                    <%= shopping %>,
                    <%= bills %>,
                    <%= entertainment %>
                ],

                backgroundColor: [
                    '#d9dbe1',
                    '#d9dbe1',
                    '#d9dbe1',
                    '#d9dbe1',
                    '#d9dbe1'
                ],

                borderRadius: 10
            }]
        },

        options: {
            responsive: true,

            plugins: {
                legend: {
                    display: false
                }
            },

            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

</script>
<script>



        const incomeModal =
        document.getElementById("incomeModal");

        const expenseModal =
        document.getElementById("expenseModal");

        function openIncomeModal(){
        incomeModal.style.display = "block";
    }

        function openExpenseModal(){
        expenseModal.style.display = "block";
    }

        function closeIncomeModal(){
        incomeModal.style.display = "none";
    }

        function closeExpenseModal(){
        expenseModal.style.display = "none";
    }

        window.onclick = function(event){

        if(event.target == incomeModal){
        incomeModal.style.display = "none";
    }

        if(event.target == expenseModal){
        expenseModal.style.display = "none";
    }
    }


</script>
</body>
</html>