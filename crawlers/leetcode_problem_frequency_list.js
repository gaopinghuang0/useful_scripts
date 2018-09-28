// fetch problem list of leetcode into json
// author: Gaoping
// since: 2018/09/27


// run in Chrome console


// Notice that table headers are different
function fetchAll() {
  const allProblemHeader = ['Status', '#', 'Title', 'Solution', 'Acceptance', 'Difficulty', 'Frequency']
  _fetchTable(allProblemHeader)
}

function fetchCompany() {
  const companyProblemHeader = ['Status', '#', 'Title', 'Acceptance', 'Difficulty', 'Frequency']
  _fetchTable(companyProblemHeader)
}

function _fetchTable(header) {
  let rows = []
  $('.table-responsive').find('tbody.reactable-data').find('tr').each(function(i) {
    let row = {}
    let tds = $(this).find('td')
    tds.each(function(idx) {
      let colName = header[idx]
      let value = null
      if (['Status', 'Frequency'].indexOf(colName) > -1) {
        value = $(this).attr('value')
      } else {
        value = $(this).text().trim()
        if (colName === '#') {
          value = parseInt(value)
        }
      }
      row[colName] = value
    })
    rows.push(row)
  })
  copy(JSON.stringify(rows))  // copy to clipboard, then save as json
  // format: [{"status": "", "id": 2, ...}, ...]
  console.log('copied to clipboard')
}

