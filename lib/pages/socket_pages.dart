import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket  extends StatelessWidget {
  


  @override
    Widget build(BuildContext context) {

      
    return Scaffold(

      body: Stack(
          children: <Widget>[
          main()
          
          ],
      ),
        );
    }

}

main(){

  IO.Socket socket = IO.io('http://167.172.216.181:3000', <String, dynamic>{
    'transports': ['websocket'],
    'extraHeaders': {'foo': 'bar'} // optional
  });
    socket.emit('nextTicket',(data) => print(data)) ;
    socket.on('nextTicket', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    
}
