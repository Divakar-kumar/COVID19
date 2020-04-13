import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/features/home/presentation/widgets/youtube_player.dart';
import 'package:flutter/material.dart';
class VideoCard extends StatelessWidget {
  final topVideos;
  final _imageURL =   'https://image.tmdb.org/t/p/w500';
  VideoCard(this.topVideos);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        try
        {
        if(topVideos["snippet"]["resourceId"]["videoId"]!=null){
        Navigator.push(context, new MaterialPageRoute(
          fullscreenDialog: true,
            builder: (context){
              return new YoutubePlayer(topVideos["snippet"]["resourceId"]["videoId"]);
            }
        ));
        }else{
          return null;
        }
        }
        catch(ex)
        {
          if(topVideos["id"]["videoId"]!=null)
          { Navigator.push(context, new MaterialPageRoute(
          fullscreenDialog: true,
            builder: (context){
              return new YoutubePlayer(topVideos["id"]["videoId"]);
            }
        ));
        }else{
          return null;
        }
        }
        },
      child: Column(
        children: <Widget>[
          new Container(
        alignment: Alignment.center,
        child: new Container(
          height: 100.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 5.0,
                offset: Offset(2.0, 3.0)
              )
            ]
          ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: CachedNetworkImage(imageUrl: topVideos["snippet"]["thumbnails"]["high"]["url"]!=null?topVideos["snippet"]["thumbnails"]["high"]["url"]:'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',fit: BoxFit.cover,alignment: Alignment.center,),
        ),
        ),
  
      ),
      Flexible(
              child: new Container(
          alignment: Alignment.center,
          width: 180.0,
          margin: const EdgeInsets.only(top: 10.0),
          
          child: new Text(topVideos["snippet"]["title"],style: TextStyle(
            fontFamily: 'google',
            fontWeight: FontWeight.w400,
            
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,),
        ),
      )
        ],
      )
    );
  }
}