Markdown file basics
====================

[Markdown file syntax reference](https://www.markdownguide.org/basic-syntax)



tips
----
* Preview in VSCode: Control + Shift + V 


* How to draw diagrams in markdown - 
    - `mermaid` is my first one and I like it! 
    - Best part - it is natively suppoed in github
    - Reference:  https://mermaid-js.github.io/mermaid/#/
    - Example: 
        - Graph
```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```


Author: [Vijay Kundanagurthi](http://twitter.com/vijred)
