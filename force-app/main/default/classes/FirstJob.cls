public class FirstJob implements queueable {
    public void execute(queueableContext qc){
        System.debug('Inside First Job');
        //Chain any job if you want
        System.enqueueJob(new SecondJob());
    }
}