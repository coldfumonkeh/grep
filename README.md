# cfGrep

A simple CFC to run regex pattern matching on a file using Java Streams.


```
<cfscript>

objGrep = new grep();

grep1 = objGrep
    .pattern( '.*public.*' )
    .file( 'grep.cfc' )
    .grep();

writedump( grep1 );

</cfscript>
```


```
<cfscript>

grep2 = objGrep
    .pattern( '^(.+)monkehworks.com' )
    .file( 'grep.cfc' )
    .grep();

writedump( grep2 );

</cfscript>
```