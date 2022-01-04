# Simple lane chart
![Compare Chart](assets/compareChart.png) 
```
Container(
     padding: EdgeInsets.symmetric(horizontal: 15),
     child: SimpleLaneChart(
     <firstValue>,
     <secondValue>,
     height: 20,
   ),
 ),
```

![Compare Chart](assets/chart.png) 
```
Container(
     padding: EdgeInsets.symmetric(horizontal: 15),
     child: SimpleLaneChart(
     <firstValue>,
     <totalValue>,
     calFrom100Perc: true,
     bgColor: Colors.deepOrange.withOpacity(0.3),
     color: Colors.deepOrange,
     height: 20,
   ),
 ),
```
