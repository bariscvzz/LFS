import json
import sys

def convert_text_to_html(input_file, output_file):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    headers = [header.strip() for header in lines[0].split()]
    rows = []

    for line in lines[1:]:
        values = [value.strip() for value in line.split()]
        row = dict(zip(headers, values))
        rows.append(row)

    table_data = {
        'columns': headers,
        'rows': rows
    }

    json_data = json.dumps(table_data)

    html = f'''
        <html>
        <head>
            <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
            <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
            <script type="text/javascript" class="init">
                $(document).ready(function() {{
                    var dataSet = {json_data};
                    var columns = dataSet.columns.map(function(column) {{
                        return {{ title: column }};
                    }});
                    var rows = dataSet.rows.map(function(row) {{
                        return Object.values(row);
                    }});

                    $('#page').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="data"></table>');
                    $('#data').DataTable({{
                        data: rows,
                        columns: columns
                    }});
                }});
            </script>
        </head>
        <body>
            <div id="page"></div>
        </body>
        </html>
    '''

    with open(output_file, 'w') as file:
        file.write(html)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python convert_to_html.py input_file output_file")
    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        convert_text_to_html(input_file, output_file)
        print("Convert complated. HTML file: " + output_file)
