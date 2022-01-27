connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"

datagroup: training_goncharenko_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_goncharenko_default_datagroup

explore: d_customer {
  label: "Customers (m)"
}

explore: d_dates {
  label: "Dates (m)"
}

explore: d_part {
  label: "Parts (m)"
}

explore: d_supplier {
  label: "Suppliers (m)"
}

explore: f_lineitems {

  label: "Items (m)"

  join: d_customer {
    type:  inner
    foreign_key: l_custkey
    relationship: many_to_one
  }
  join: d_order_dates {
    type: left_outer
    from: d_dates
    foreign_key: f_lineitems.l_orderdatekey
    relationship: many_to_one
    view_label: "Order date"
  }
  join: d_commit_dates {
    type: left_outer
    from: d_dates
    foreign_key: f_lineitems.l_commitdatekey
    relationship: many_to_one
    view_label: "Commit date"
  }
  join: d_receipt_dates {
    type: left_outer
    from: d_dates
    foreign_key: f_lineitems.l_receiptdatekey
    relationship: many_to_one
    view_label: "Receipt date"
  }
  join: d_ship_dates {
    type: left_outer
    from: d_dates
    foreign_key: f_lineitems.l_shipdatekey
    relationship: many_to_one
    view_label: "Ship date"
  }
  join: d_part {
    type: inner
    foreign_key: f_lineitems.l_partkey
    relationship: many_to_one
  }
  join: d_supplier {
    type: inner
    foreign_key: f_lineitems.l_suppkey
    relationship: many_to_one
  }

}
