public class FutureExample {
    public FutureExample(){
        abc();
        xyz();
        rst();
        wxy();
    }
    @future
    public static void abc(){
       System.debug('Inside abc Method'); 
        // xyz(); through an error : System.AsyncException: Future method cannot be called from a future or batch method: FutureExample.xyz()
    }
    @future
    public static void xyz(){
       System.debug('Inside xyz Method'); 
    }
    @future
    public static void rst(){
       System.debug('Inside rst Method'); 
    }
      @future
    public static void wxy(){
        System.debug('Inside wxy Method');
    }
    
}