ExAerospike
===========


this is light wrapper around aerospike erlang driver      
      
usage       

connect         
         db=ExAerospike         
         con = db.connect        
	 con = db.connect 'ip','port'         
         db.close conn       

options      
         con = db.namespace con, 'namespace'         
         con = db.set con, 'aerospikeSetName'         

read     
         db.get con, 'key','5'         
         db.get con, 'key'         

write     
         db.write con, 'key', 'bin', 'value'         
         db.write con, 'key',['1': '2','3': '4','5': '6']         

del     
         db.delete con, 'key'         
         
