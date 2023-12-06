final jsonExample = {
  "name": "Table 1.0.0-alpha",
  "columns": [
    {
      "is_editable": false,
      "is_nullable": false,
      "name": "Nome",
      "subtype": "normal",
      "type": "text"
    },
    {
      "is_editable": true,
      "is_nullable": false,
      "name": "E-mail",
      "subtype": "email",
      "type": "text"
    },
    {
      "is_editable": true,
      "is_nullable": false,
      "name": "Salário",
      "type": "numeric"
    },
    {
      "is_editable": false,
      "is_nullable": false,
      "name": "Zipcode",
      "type": "text"
    },
    {
      "is_editable": true,
      "is_nullable": false,
      "name": "Empresa",
      "type": "text"
    },
  ],
  "rows": [
    ["Luiz", "luiz@gmail.com", 9000, '88220-000', 'Empresa 1'],
    ["Artur", "artur@gmail.com", 10000, '88220-000', 'Empresa 2'],
    ["Felipe", "felipe@gmail.com", 100000, '88220-000', 'Empresa 3']
  ]
};
