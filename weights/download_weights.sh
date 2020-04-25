mkdir pre

wget https://files.catbox.moe/maqp2o.137
mv maqp2o.137 yolov4.conv.137
cd pre
wget https://files.catbox.moe/mmkot2.002
wget https://files.catbox.moe/1ab142.001
cat yolov4.weights.001 yolov4.weights.002 >> yolov4.weights



