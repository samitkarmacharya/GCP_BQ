connection: "bigquery"

include: "/views/*.view.lkml"

explore: sample_sales {
  label: "Sample Sales"
  description: "Example explore over sample sales data."
}
