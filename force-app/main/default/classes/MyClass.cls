public class MyClass {
    
    {
        System.debug('Initializer block');
    }
    public void MyMethod(){
        System.debug('MyMethod Block');
    }
    static{
       System.debug('Static Block'); 
    }
    public MyClass(){
        System.debug('Constructor block');
    }
    
}