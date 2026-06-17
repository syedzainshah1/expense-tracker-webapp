const expenseModal =
    document.getElementById("expenseModal");

const incomeModal =
    document.getElementById("incomeModal");

function openExpenseModal(){
    expenseModal.style.display = "block";
}

function closeExpenseModal(){
    expenseModal.style.display = "none";
}

function openIncomeModal(){
    incomeModal.style.display = "block";
}

function closeIncomeModal(){
    incomeModal.style.display = "none";
}



    // 1. Grab the canvas element
    const ctx = document.getElementById('expenseChart');

    // 2. Clear out any potential hidden character typos on this line:
    new Chart(ctx, {
    type: 'line',
    data: {
    labels: ['Food', 'Travel', 'Shopping', 'Bills', 'Entertainment'],
    datasets: [{
    label: 'Expenses',
    data: [
    Number("<%= food %>"),
    Number("<%= travel %>"),
    Number("<%= shopping %>"),
    Number("<%= bills %>"),
    Number("<%= entertainment %>")
    ],
    borderWidth: 3,
    tension: 0.4
}]
},
    options: {
    responsive: true,
    scales: {
    y: {
    beginAtZero: true
}
}
}
});
