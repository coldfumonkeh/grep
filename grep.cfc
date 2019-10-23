/**
* Name: grep.cfc
* Purpose: Performs basic grep functionality using Java 8 streams for CFML
* Author: Matt Gifford (https://www.monkehworks.com)
*/
component accessors="true" {

    property name="grepPattern" type="string";
    property name="filePath" type="string";

    property name="jStream";

    variables.pattern = createObject( "java", "java.util.regex.Pattern" );

    /**
     * Instantiate
     */
    public grep function init(){
        return this;
    }

    /**
     * Sets a pattern into the component to be used in the filter
     * 
     * @patternString The pattern string to be used
     */
    public grep function pattern( required string patternString ){
        setGrepPattern( variables.pattern.compile( arguments.patternString ).asPredicate() );
        return this;
    }

    /**
     * Sets the file path to be read
     * 
     * @filePath The path of the file to be read
     */
    public grep function file( required string filePath ){
        setFilePath( arguments.filePath );
        return this;
    }

    /**
     * Performs the actual grep using the file stream and the pattern as the predicate
     */
    public array function grep(){
        variables.jStream = createObject( "java", "java.nio.file.Files" )
            .lines(
                createObject( "java", "java.nio.file.Paths" ).get(
                    createObject( "java", "java.io.File" ).init( getFilePath() ).toURI()
                ),
                createObject( "java", "java.nio.charset.Charset" ).forName( "UTF-8" )
            );
        variables.jStream = variables.jStream.filter( getGrepPattern() );
        return variables.jStream.toArray();
    }

}