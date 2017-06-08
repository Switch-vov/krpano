<#assign base=request.contextPath />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>全景图上传</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="${base}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${base}/css/webuploader.css" rel="stylesheet">
    <link href="${base}/css/style.css" rel="stylesheet">

</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h3 class="text-center text-info">
                图片上传
            </h3>
            <div class="row">
                <div class="col-md-4">

                </div>
                <div class="col-md-4">
                    <div class="col-md-12">
                        <!--用来存放item-->
                        <div id="thelist" class="uploader-list">

                        </div>
                        <div>
                            <div id="filePicker">选择图片</div>
                            <button id="ctlBtn" class="btn btn-default">开始上传</button>
                            <button id="makePanoBtn" href="#modal-container-make-pano-conform" role="button"
                                    class="btn btn-default" data-toggle="modal">创建全景图
                            </button>
                            <button id="visitPanoBtn" class="btn btn-default">访问全景图</button>
                            <button id="visitPanoEmbeddedBtn" class="btn btn-default">访问全景图-嵌入式</button>
                            <div class="modal fade" id="modal-container-make-pano-conform" role="dialog"
                                 aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">

                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                                ×
                                            </button>
                                            <h4 class="modal-title" id="myModalLabel">
                                                创建全景图
                                            </h4>
                                        </div>
                                        <div class="modal-body">
                                            是否确定？
                                        </div>
                                        <div class="modal-footer">

                                            <button type="button" class="btn btn-default" data-dismiss="modal">
                                                取消
                                            </button>
                                            <button id="makePano" type="button" class="btn btn-primary" data-dismiss="modal">
                                                创建
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">

                </div>
            </div>
        </div>
    </div>
</div>

<script src="${base}/js/jquery.min.js"></script>
<script src="${base}/js/bootstrap.min.js"></script>
<script src="${base}/js/webuploader.nolog.min.js"></script>
<script src="${base}/js/scripts.js"></script>
<script type="text/javascript">
    var uid = Math.ceil(Math.random() * 10000);
    var cate = Math.ceil(Math.random() * 10000);
    var isClick = true;
    $(function () {
        /*init webuploader*/
        var $list = $("#thelist");   //这几个初始化全局的百度文档上没说明，好蛋疼。
        var $btn = $("#ctlBtn");    //开始上传
        var thumbnailWidth = 100;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档
        var thumbnailHeight = 100;

        var uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: false,
            // swf文件路径
            swf: '${base}/js/Uploader.swf',

            // 文件接收服务端。
            server: '${base}/upload',

            compress:false,

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#filePicker',

            // 只允许选择图片文件。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            },
            method: 'POST'
        });
        uploader.options.formData.uid = uid;
        uploader.options.formData.cate = cate;

        // 当有文件添加进来的时候
        uploader.on('fileQueued', function (file) {  // webuploader事件.当选择文件后，文件被加载到文件队列中，触发该事件。等效于 uploader.onFileueued = function(file){...} ，类似js的事件定义。
            var $li = $(
                            '<div id="' + file.id + '" class="file-item thumbnail">' +
                            '<img>' +
                            '<div class="info">' + file.name + '</div>' +
                            '</div>'
                    ),
                    $img = $li.find('img');


            // $list为容器jQuery实例
            $list.append($li);

            // 创建缩略图
            // 如果为非图片文件，可以不用调用此方法。
            // thumbnailWidth x thumbnailHeight 为 100 x 100
            uploader.makeThumb(file, function (error, src) {   //webuploader方法
                if (error) {
                    $img.replaceWith('<span>不能预览</span>');
                    return;
                }

                $img.attr('src', src);
            }, thumbnailWidth, thumbnailHeight);
        });
        // 文件上传过程中创建进度条实时显示。
        uploader.on('uploadProgress', function (file, percentage) {
            var $li = $('#' + file.id),
                    $percent = $li.find('.progress span');

            // 避免重复创建
            if (!$percent.length) {
                $percent = $('<p class="progress"><span></span></p>')
                        .appendTo($li)
                        .find('span');
            }

            $percent.css('width', percentage * 100 + '%');
        });

        // 文件上传成功，给item添加成功class, 用样式标记上传成功。
        uploader.on('uploadSuccess', function (file) {
            $('#' + file.id).addClass('upload-state-done');
        });

        // 文件上传失败，显示上传出错。
        uploader.on('uploadError', function (file) {
            var $li = $('#' + file.id),
                    $error = $li.find('div.error');

            // 避免重复创建
            if (!$error.length) {
                $error = $('<div class="error"></div>').appendTo($li);
            }

            $error.text('上传失败');
        });

        // 完成上传完了，成功或者失败，先删除进度条。
        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').remove();
        });
        $btn.on('click', function () {
            console.log("上传...");
            uploader.upload();
            console.log("上传成功");
        });
    });
</script>
<script>
    $(function () {
        $('#makePano').click(function () {
            if (isClick) {
                $.ajax({
                    url: '${base}/krpano/makePano',
                    data: {'uid': uid, 'cate': cate},
                    beforeSend: function (request) {
                        isClick = false;
                    },
                    success: function (data) {
                        $("#modal-container-make-pano-conform").css('display', "none");
                        alert("创建成功");
                    },
                    error: function () {
                        $("#modal-container-make-pano-conform").css('display', "none");
                        alert("创建失败");
                        isClick = true;
                    }
                });
            }
        });

        $('#visitPanoBtn').click(function () {
            window.location.href = '${base}/krpano/visitPano?uid=' + uid + "&cate=" + cate;
        });
        $('#visitPanoEmbeddedBtn').click(function () {
            window.location.href = '${base}/krpano/visitPanoEmbedded?uid=' + uid + "&cate=" + cate;
        });
    });
</script>
</body>
</html>