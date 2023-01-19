(map(keys_unsorted) | unique | add) as $cols
  | map(. as $row | $cols | map($row[.])) as $rows
  | $cols, $rows[]
  | join(";")