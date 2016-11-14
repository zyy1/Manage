<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="${pageContext.request.contextPath }/css/all-krajee.css"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath }/js/fileInput/css/fileinput.css"
	media="all" rel="stylesheet" type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/fileInput/js/fileinput.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/fileInput/js/fileinput_locale_zh.js">
</script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/artDialog.js?skin=default"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
body{
	padding-top: 10px;
}
</style>
<body>
	<form enctype="multipart/form-data">
	<div class="well"><h2 class="h2"><span class="fa fa-mail-reply-all"></span>导入数据</h2></div>
		<div class="form-group">
			<input id="file-ready" name="file" class="file" type="file" multiple
				data-preview-file-type="any"
				data-upload-url="FileAction_importData?attachmentType=${attachmentType}">
		</div>
	</form>

</body>
<script>
	$("#file-ready").fileinput({
		'showPreview' : true,
		/* 初始化上传的文件         'initialPreview' : "aaaa", */
		'elErrorContainer' : '#errorBlock',
		language : 'zh',
		maxFileSize : 500000,
		maxFilePreviewSize : 500000,
		allowedFileExtensions: ["xls","xlsx"],
		uploadTitle: "导入数据",
		uploadLabel:"导入",
	}).on("fileuploaderror",function(){
		art.dialog({icon:'error', title:'友情提示', drag:true, resize:false, content:'导入错误！请检查文件格式和内容是否对照，推荐使用模板文件导入。', ok:true,lock:true});
	}).on("fileuploaded",function(){
		art.dialog({icon:'succeed', title:'友情提示', drag:true, resize:false, content:'导入成功！', ok:true,lock:true});
	});
</script>
</html>