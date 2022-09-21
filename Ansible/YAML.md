YAML examples / Samples 
------------------------


  * YAML - What is difference between Dictionary and List(Array) or List of Dictionaries(Map), value key pair 
    - 
```
List is ordered collection 
 - SampleList1
 - SampleList2
 - SampleList3

Dictionary is unordered   
 -  SampleDictionary1: Value1
    Property2: Value2
    PropertyofDictionary3: 
      Property1ofdictionary3: value4
      Property2ofdictionary3: value5
 -  SampleDictionary1: Value10
    Property2: Value20
    PropertyofDictionary3: 
      Property1ofdictionary3: value40
      Property2ofdictionary3: value50
 -  SampleDictionary1: Value11
    Property2: Value12
    PropertyofDictionary3: 
      Property1ofdictionary3: value14
      Property2ofdictionary3: value15

```

* Example of properties 
```
employee:
    name: john
    gender: male
    age: 24
```

* Example of dictionary detailed nodes 
```
employee:
    name: john
    gender: male
    age: 24
    address:
        city: edison
        state: new jersey
        country: united states
```

* Example of array 
```
- apple
- apple
- apple
- grape


# One more example -
employee:
    name: john
    gender: male
    age: 24
    address:
        city: edison
        state: 'new jersey'
        country: 'united states'
    payslips:
        -
            month: june
            amount: 1400
        -
            month: july
            amount: 2400
        -
            month: august
            amount: 3400
```

* Shre one of the ways to verify YAML format 
    -   https://yamllink.com 

