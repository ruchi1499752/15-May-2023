public class AsyncExecutionExample implements Queueable {
    public void execute(QueueableContext con){
        Account a = new Account(name='Lemovo', Phone = '(415) 555-1212');
        Insert a;
    }
    public void execute1(QueueableContext con){
          Contact a = new Contact(Lastname='Ronak');
       	  Insert a;
    }

}