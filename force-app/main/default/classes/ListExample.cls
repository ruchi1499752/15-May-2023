public with sharing class ListExample {
   public static void accessList(){

    String str = 'Ruchi Chourasia';
    Blob b = Blob.valueOf(str);
    system.debug('Blob :' + b);
    system.debug('Blob :' + b.toString());

    

    List<Integer> my_list = new List<Integer>();
    List<Integer> num = new List<Integer>{1,2,3};
    System.debug('My_List is :' + my_list);

    System.debug('Number is :' + num);

    Set<Integer> mySet = new Set<Integer>{1,3,67,8,2,1};
    System.debug('Set is :' + mySet);

    Map<Integer,String> my_Map = new Map<Integer, String>();
    Map<Integer,String> my_Map1 = new Map<Integer, String>{1 => 'Ruchi', 2 => 'Nisha', 3 => 'Gul', 3 => 'Komal'};
    System.debug('My Map 1 :' + my_Map1);
    System.debug('Get Value :' + my_Map1.get(1));

    for(Integer n : my_Map1.keySet()){
        System.debug('Values is :' + n + ':' + my_Map1.get(n) );
    }

    List<Integer> listOfInteger = new List<Integer>();
    for(Integer i = 1; i <= 20 ; i++){
        listOfInteger.add(i);
    }
    System.debug('List Of Integers :' + listOfInteger);
    Integer sum =0;
    for(Integer i =1; i< listOfInteger.size() ; i++){
        if(Math.mod(listOfInteger[i], 2) != 0){
            System.debug(listOfInteger[i]);
            sum = sum + listOfInteger[i];
            
        }
    }
    System.debug('Sum :' + sum);

   }
}