const tujuan = {"PDMJ", "LBS"};
const supplierLimbah = {"LO148", "LO158", "LO160", "LO089", "WORKSHOP"};

const wasteStoreCode = {
  "Pelumas Bekas": "OLI",
  "Filter Bekas": "FIL",
  "Hose Terkontaminasi": "HOS",
  "Majun Terkontaminasi": "MJN",
  "Material Terkontaminasi": "MTN",
  "Grease Bekas": "GRS",
  "Accu Bekas (200 AH)": "A200",
  "Accu Bekas (150 AH)": "A150",
  "Accu Bekas (100 AH)": "A100",
  "Accu Bekas (70 AH)": "A70",
  "Solar Bekas": "SOL",
  "Limbah Medis": "MED",
  "Limbah Lampu TL": "LAMP"
};

const jsonWasteData = [
  {
    "name": "Pelumas Bekas",
    "conversionfactor": 200,
    "issellable": true,
    "tariffperpack": 15000,
    "wastecode": "B105d",
    "logbookconversion": true
  },
  {
    "name": "Filter Bekas",
    "conversionfactor": 140,
    "issellable": false,
    "tariffperpack": 975000,
    "wastecode": "B110d",
    "logbookconversion": false
  },
  {
    "name": "Hose Terkontaminasi",
    "conversionfactor": 120,
    "issellable": false,
    "tariffperpack": 975000,
    "wastecode": "B110d",
    "logbookconversion": false
  },
  {
    "name": "Majun Terkontaminasi",
    "conversionfactor": 120,
    "issellable": false,
    "tariffperpack": 975000,
    "wastecode": "B110d",
    "logbookconversion": false
  },
  {
    "name": "Material Terkontaminasi",
    "conversionfactor": 360,
    "issellable": false,
    "tariffperpack": 1650000,
    "wastecode": "A108d",
    "logbookconversion": false
  },
  {
    "name": "Grease Bekas",
    "conversionfactor": 190,
    "issellable": false,
    "tariffperpack": 1650000,
    "wastecode": "A108d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (200 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 100000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (150 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 75000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (100 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 50000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (70 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 35000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (50 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 25000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Aki Bekas (20 AH)",
    "conversionfactor": 30,
    "issellable": true,
    "tariffperpack": 10000,
    "wastecode": "A102d",
    "logbookconversion": false
  },
  {
    "name": "Solar Bekas",
    "conversionfactor": 200,
    "issellable": false,
    "tariffperpack": 1650000,
    "wastecode": "B105d",
    "logbookconversion": false
  },
  {
    "name": "Limbah Medis",
    "conversionfactor": 1,
    "issellable": false,
    "tariffperpack": 50000,
    "wastecode": "A337-1",
    "logbookconversion": false
  },
  {
    "name": "Limbah Lampu TL",
    "conversionfactor": 1,
    "issellable": false,
    "tariffperpack": 1000000,
    "wastecode": "B107d",
    "logbookconversion": false
  },
];
