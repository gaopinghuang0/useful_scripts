// fetch problem list of leetcode into json
// author: Gaoping
// since: 2018/09/27


// run in Chrome console


// Notice that table headers are different
const company_problem_header = ['Status', '#', 'Title', 'Acceptance', 'Difficulty', 'Frequency']
const all_problem_header = ['Status', '#', 'Title', 'Solution', 'Acceptance', 'Difficulty', 'Frequency']

let FETCH_ALL = true
let rows = []
if (FETCH_ALL) {
  rows.push(all_problem_header)
} else {
  rows.push(company_problem_header)
}

$('.table-responsive').find('tbody').find('tr').each(function(i) {
  let row = []
  let tds = $(this).find('td')
  tds.each(function(idx) {
    if (idx === 0 || idx === tds.length-1) {
      row.push($(this).attr('value'))
    } else {
      row.push($(this).text().trim())
    }
  })
  rows.push(row)
})

copy(JSON.stringify(rows))  // copy to clipboard, then save as json