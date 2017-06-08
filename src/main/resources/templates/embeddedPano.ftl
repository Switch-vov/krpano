<#assign base=request.contextPath />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>嵌入式全景图</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="${base}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${base}/css/webuploader.css" rel="stylesheet">
    <link href="${base}/css/style.css" rel="stylesheet">

    <mce:style>
        <!--
            body { margin: 0px;  }
            iframe {border: 0px;}  -->
    </mce:style>
    <style mce_bogus="1">
        body { margin: 0px; }
        iframe {border: 0px;}
    </style>
</head>
<body scroll="no">
<iframe src="${panoSrc}" id="frame3d" name="frame3d" width="100%" height="100%" marginheight="0px" marginwidth="0px" scrolling="no" frameborder="0" onload="this.style.height=document.body.clientHeight"
        mce_src="${panoSrc}">

</iframe>
<div class="container-fluid">

</div>

<script src="${base}/js/jquery.min.js"></script>
<script src="${base}/js/bootstrap.min.js"></script>
<script src="${base}/js/scripts.js"></script>
<mce:script type="text/javascript"><!--
        function resize(){
            document.getElementById('frame3d').style.height = document.body.clientHeight +"px";
        }
        window.onresize = resize;

// --></mce:script>
</body>
</html>