public class SecondJob implements queueable {
    public void execute(queueableContext q){
        System.debug('Inside Second Job');
        
    }
}