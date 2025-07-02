Describe 'HelloWorld Module' {
    It 'should return Hello, World!' {
        $result = HelloWorld
        Assert-MockCalled HelloWorld -Exactly 1 -Scope It
        $result | Should -Be 'Hello, World!'
    }
}