# PyTorch-YOLOv4

YOLOv4的最小PyTorch实现，开箱即用，并支持训练，推断和评估，基于 [https://github.com/eriklindernoren/PyTorch-YOLOv3](https://github.com/eriklindernoren/PyTorch-YOLOv3) & [https://github.com/Python3WebSpider/DeepLearningSlideCaptcha](https://github.com/Python3WebSpider/DeepLearningSlideCaptcha)修改。

[English](./README.md)
## 克隆项目

### 克隆部署命令

```
git clone https://github.com.cnpmjs.org/SOVLOOKUP/PyTorch-YOLOv4
cd PyTorch-YOLOv4/
sudo pip3 install -r requirements.txt
```


### 下载预训练模型

```
$ cd weights/                                # Navigate to data dir
$ bash download_weights.sh              # Will download coco dataset
``` 

### 另外如果你要查看COCO数据集

```
$ cd data/                                # Navigate to data dir
$ bash get_coco_dataset.sh                # Will download coco dataset
```

## 数据准备

使用 LabelImg 工具标注自行标注一批数据，大约每类 200 张以上即可训练出不错的效果。

LabelImg：[https://github.com/tzutalin/labelImg](https://github.com/tzutalin/labelImg)

标注要求：

* 圈出验证码目标滑块区域的完整完整矩形，无需标注源滑块。
* 目标矩形命名为 target 这个类别。
* 建议使用 LabelImg 的快捷键提高标注效率。

## 训练

本项目已经提供了标注好的数据集，在 data/captcha，可以直接使用。

当前数据训练命令：

```
python3 train.py --model_def config/yolov4-captcha.cfg --data_config config/captcha.data --pretrained_weights weights/pre/yolov4.conv.137

```

实测 P100 训练时长约 15 秒一个 epoch，大约几分钟即可训练出较好效果。

### Tensorboard
Track training progress in Tensorboard:
* Initialize training
* Run the command below
* Go to http://localhost:6006/

```
$ tensorboard --logdir='logs' --port=6006
```

## 训练自定义数据集

如果要训练自己的数据，数据格式准备见：[https://github.com/eriklindernoren/PyTorch-YOLOv3#train-on-custom-dataset](https://github.com/eriklindernoren/PyTorch-YOLOv3#train-on-custom-dataset)。

使用下面的命令创建自定义模型, 替换 `<num-classes>` 为您数据集类别。

```
$ cd config/                                # Navigate to config dir
$ bash create_custom_model.sh <num-classes> # Will create custom model 'yolov4-custom.cfg'
```

当前数据训练命令：
```
python3 train.py --model_def config/yolov4-custom.cfg --data_config config/{YourSetName}.data --pretrained_weights weights/pre/yolov4.conv.137

```

## 测试

训练完毕之后会在 checkpoints 文件夹生成 pth 文件，可直接使用模型来预测生成标注结果。

如之前跳过了 Git LFS 文件下载，则可以使用如下命令下载 Git LFS 文件：

```
git lfs pull
```

此时 checkpoints 文件夹会生成训练好的 pth 文件。

当前数据测试命令：

```
python3 detect.py --model_def config/yolov4-captcha.cfg --weights_path checkpoints/yolov4_ckpt.pth --image_folder data/captcha/test --class_path data/captcha/classes.names

```

该脚本会读取 captcha 下的 test 文件夹所有图片，并将处理后的结果输出到 test 文件夹。

运行结果样例：

```
Performing object detection:
        + Batch 0, Inference Time: 0:00:00.044223
        + Batch 1, Inference Time: 0:00:00.028566
        + Batch 2, Inference Time: 0:00:00.029764
        + Batch 3, Inference Time: 0:00:00.032430
        + Batch 4, Inference Time: 0:00:00.033373
        + Batch 5, Inference Time: 0:00:00.027861
        + Batch 6, Inference Time: 0:00:00.031444
        + Batch 7, Inference Time: 0:00:00.032110
        + Batch 8, Inference Time: 0:00:00.029131

Saving images:
(0) Image: 'data/captcha/test/captcha_4497.png'
        + Label: target, Conf: 0.99999
(1) Image: 'data/captcha/test/captcha_4498.png'
        + Label: target, Conf: 0.99999
(2) Image: 'data/captcha/test/captcha_4499.png'
        + Label: target, Conf: 0.99997
(3) Image: 'data/captcha/test/captcha_4500.png'
        + Label: target, Conf: 0.99999
(4) Image: 'data/captcha/test/captcha_4501.png'
        + Label: target, Conf: 0.99997
(5) Image: 'data/captcha/test/captcha_4502.png'
        + Label: target, Conf: 0.99999
(6) Image: 'data/captcha/test/captcha_4503.png'
        + Label: target, Conf: 0.99997
(7) Image: 'data/captcha/test/captcha_4504.png'
        + Label: target, Conf: 0.99998
(8) Image: 'data/captcha/test/captcha_4505.png'
        + Label: target, Conf: 0.99998
```

样例结果：

![](data/captcha/result/captcha_4501.png)

![](data/captcha/result/captcha_4505.png)

![](data/captcha/result/captcha_4503.png)

## 协议

本项目基于开源 [GNU 协议](https://github.com/eriklindernoren/PyTorch-YOLOv3/blob/master/LICENSE)，另外本项目不提供任何有关滑动轨迹相关模拟和 JavaScript 逆向分析方案。

本项目仅供学习交流使用，请勿用于非法用途，本人不承担任何法律责任。

如有侵权请联系个人删除，谢谢。
