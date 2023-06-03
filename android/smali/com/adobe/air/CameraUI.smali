.class public final Lcom/adobe/air/CameraUI;
.super Ljava/lang/Object;
.source "CameraUI.java"

# interfaces
.implements Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;


# static fields
.field public static final ERROR_ACTIVITY_DESTROYED:I = 0x4

.field public static final ERROR_CAMERA_BUSY:I = 0x1

.field public static final ERROR_CAMERA_ERROR:I = 0x2

.field public static final ERROR_CAMERA_UNAVAILABLE:I = 0x3

.field private static final LOG_TAG:Ljava/lang/String; = "CameraUI"

.field private static final PHONE_STORAGE:Ljava/lang/String; = "phoneStorage"

.field public static final REQUESTED_MEDIA_TYPE_IMAGE:I = 0x1

.field public static final REQUESTED_MEDIA_TYPE_INVALID:I = 0x0

.field public static final REQUESTED_MEDIA_TYPE_VIDEO:I = 0x2

.field private static sCameraRollPath:Ljava/lang/String;

.field private static sCameraUI:Lcom/adobe/air/CameraUI;


# instance fields
.field private mCameraBusy:Z

.field private mImagePath:Ljava/lang/String;

.field private mLastClientId:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 88
    sput-object v0, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;

    .line 91
    sput-object v0, Lcom/adobe/air/CameraUI;->sCameraUI:Lcom/adobe/air/CameraUI;

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .prologue
    .line 140
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 99
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 101
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/CameraUI;->mCameraBusy:Z

    .line 103
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    .line 142
    return-void
.end method

.method private getCameraRollDirectory(Landroid/app/Activity;)Ljava/lang/String;
    .locals 7
    .param p1, "activity"    # Landroid/app/Activity;

    .prologue
    const/4 v6, 0x0

    .line 594
    sget-object v3, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;

    if-eqz v3, :cond_0

    .line 596
    sget-object v3, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;

    .line 665
    :goto_0
    return-object v3

    .line 599
    :cond_0
    const/4 v1, 0x0

    .line 601
    .local v1, "imageUri":Landroid/net/Uri;
    if-nez v1, :cond_1

    .line 607
    :try_start_0
    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    sget-object v4, Landroid/provider/MediaStore$Images$Media;->INTERNAL_CONTENT_URI:Landroid/net/Uri;

    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_3

    move-result-object v1

    .line 619
    :cond_1
    :goto_1
    if-nez v1, :cond_2

    .line 623
    :try_start_1
    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    const-string v4, "phoneStorage"

    invoke-static {v4}, Landroid/provider/MediaStore$Images$Media;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    new-instance v5, Landroid/content/ContentValues;

    invoke-direct {v5}, Landroid/content/ContentValues;-><init>()V

    invoke-virtual {v3, v4, v5}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    move-result-object v1

    .line 633
    :cond_2
    :goto_2
    if-eqz v1, :cond_4

    .line 637
    :try_start_2
    invoke-direct {p0, v1, p1}, Lcom/adobe/air/CameraUI;->getFileFromUri(Landroid/net/Uri;Landroid/app/Activity;)Ljava/io/File;

    move-result-object v0

    .line 638
    .local v0, "f":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;
    :try_end_2
    .catch Landroid/content/ActivityNotFoundException; {:try_start_2 .. :try_end_2} :catch_0
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 647
    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, v1, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 648
    const/4 v1, 0x0

    .line 665
    .end local v0    # "f":Ljava/io/File;
    :cond_3
    :goto_3
    sget-object v3, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;

    goto :goto_0

    .line 639
    :catch_0
    move-exception v3

    .line 647
    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, v1, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 648
    const/4 v1, 0x0

    .line 649
    goto :goto_3

    .line 642
    :catch_1
    move-exception v3

    .line 647
    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, v1, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 648
    const/4 v1, 0x0

    .line 649
    goto :goto_3

    .line 647
    :catchall_0
    move-exception v3

    invoke-virtual {p1}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    invoke-virtual {v4, v1, v6, v6}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 648
    const/4 v1, 0x0

    throw v3

    .line 655
    :cond_4
    sget-object v3, Landroid/os/Environment;->DIRECTORY_PICTURES:Ljava/lang/String;

    invoke-static {v3}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    .line 657
    .local v2, "pictureFolderPath":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 659
    invoke-virtual {v2}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Lcom/adobe/air/CameraUI;->sCameraRollPath:Ljava/lang/String;

    goto :goto_3

    .line 627
    .end local v2    # "pictureFolderPath":Ljava/io/File;
    :catch_2
    move-exception v3

    goto :goto_2

    .line 611
    :catch_3
    move-exception v3

    goto :goto_1
.end method

.method public static declared-synchronized getCameraUI()Lcom/adobe/air/CameraUI;
    .locals 3

    .prologue
    .line 153
    const-class v1, Lcom/adobe/air/CameraUI;

    monitor-enter v1

    :try_start_0
    sget-object v0, Lcom/adobe/air/CameraUI;->sCameraUI:Lcom/adobe/air/CameraUI;

    if-nez v0, :cond_0

    .line 156
    new-instance v0, Lcom/adobe/air/CameraUI;

    invoke-direct {v0}, Lcom/adobe/air/CameraUI;-><init>()V

    sput-object v0, Lcom/adobe/air/CameraUI;->sCameraUI:Lcom/adobe/air/CameraUI;

    .line 157
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    sget-object v2, Lcom/adobe/air/CameraUI;->sCameraUI:Lcom/adobe/air/CameraUI;

    invoke-virtual {v0, v2}, Lcom/adobe/air/AndroidActivityWrapper;->addActivityResultListener(Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;)V

    .line 160
    :cond_0
    sget-object v0, Lcom/adobe/air/CameraUI;->sCameraUI:Lcom/adobe/air/CameraUI;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v1

    return-object v0

    .line 153
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method

.method private getCursorFromUri(Landroid/net/Uri;Landroid/app/Activity;[Ljava/lang/String;)Landroid/database/Cursor;
    .locals 10
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "activity"    # Landroid/app/Activity;
    .param p3, "cursorProj"    # [Ljava/lang/String;

    .prologue
    const/4 v9, 0x0

    const/4 v7, 0x1

    const/4 v8, 0x0

    .line 247
    const/4 v6, 0x0

    .line 250
    .local v6, "cursor":Landroid/database/Cursor;
    :try_start_0
    invoke-virtual {p2}, Landroid/app/Activity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v1, p1

    move-object v2, p3

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 252
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v0

    if-eqz v0, :cond_3

    .line 263
    if-eqz v6, :cond_1

    move v0, v7

    :goto_0
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-nez v1, :cond_2

    :goto_1
    and-int/2addr v0, v7

    if-eqz v0, :cond_0

    .line 265
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    .line 258
    .end local v6    # "cursor":Landroid/database/Cursor;
    :cond_0
    :goto_2
    return-object v6

    .restart local v6    # "cursor":Landroid/database/Cursor;
    :cond_1
    move v0, v8

    .line 263
    goto :goto_0

    :cond_2
    move v7, v8

    goto :goto_1

    .line 257
    :cond_3
    :try_start_1
    invoke-interface {v6}, Landroid/database/Cursor;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 263
    if-eqz v6, :cond_5

    move v0, v7

    :goto_3
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v1

    if-nez v1, :cond_6

    :goto_4
    and-int/2addr v0, v7

    if-eqz v0, :cond_4

    .line 265
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_4
    move-object v6, v9

    .line 258
    goto :goto_2

    :cond_5
    move v0, v8

    .line 263
    goto :goto_3

    :cond_6
    move v7, v8

    goto :goto_4

    :catchall_0
    move-exception v0

    move-object v1, v0

    if-eqz v6, :cond_8

    move v0, v7

    :goto_5
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v2

    if-nez v2, :cond_9

    :goto_6
    and-int/2addr v0, v7

    if-eqz v0, :cond_7

    .line 265
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_7
    throw v1

    :cond_8
    move v0, v8

    .line 263
    goto :goto_5

    :cond_9
    move v7, v8

    goto :goto_6
.end method

.method private getFileFromUri(Landroid/net/Uri;Landroid/app/Activity;)Ljava/io/File;
    .locals 8
    .param p1, "uri"    # Landroid/net/Uri;
    .param p2, "activity"    # Landroid/app/Activity;

    .prologue
    .line 220
    const/4 v1, 0x0

    .line 221
    .local v1, "f":Ljava/io/File;
    const/4 v6, 0x1

    new-array v5, v6, [Ljava/lang/String;

    const/4 v6, 0x0

    const-string v7, "_data"

    aput-object v7, v5, v6

    .line 224
    .local v5, "proj":[Ljava/lang/String;
    invoke-direct {p0, p1, p2, v5}, Lcom/adobe/air/CameraUI;->getCursorFromUri(Landroid/net/Uri;Landroid/app/Activity;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    .line 225
    .local v0, "cursor":Landroid/database/Cursor;
    if-eqz v0, :cond_0

    .line 229
    :try_start_0
    const-string v6, "_data"

    invoke-interface {v0, v6}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v4

    .line 230
    .local v4, "nativePath_index":I
    invoke-interface {v0, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    .line 231
    .local v3, "nativePath":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 237
    .end local v1    # "f":Ljava/io/File;
    .local v2, "f":Ljava/io/File;
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 238
    const/4 v0, 0x0

    move-object v1, v2

    .line 242
    .end local v2    # "f":Ljava/io/File;
    .end local v3    # "nativePath":Ljava/lang/String;
    .end local v4    # "nativePath_index":I
    .restart local v1    # "f":Ljava/io/File;
    :cond_0
    :goto_0
    return-object v1

    .line 232
    :catch_0
    move-exception v6

    .line 237
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 238
    const/4 v0, 0x0

    .line 239
    goto :goto_0

    .line 237
    :catchall_0
    move-exception v6

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 238
    const/4 v0, 0x0

    throw v6
.end method

.method private native nativeOnCameraCancel(J)V
.end method

.method private native nativeOnCameraError(JI)V
.end method

.method private native nativeOnCameraResult(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method private onCameraCancel()V
    .locals 4

    .prologue
    const-wide/16 v2, 0x0

    .line 121
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 123
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    invoke-direct {p0, v0, v1}, Lcom/adobe/air/CameraUI;->nativeOnCameraCancel(J)V

    .line 125
    iput-wide v2, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 127
    :cond_0
    return-void
.end method

.method private onCameraError(I)V
    .locals 4
    .param p1, "cameraErrorId"    # I

    .prologue
    const-wide/16 v2, 0x0

    .line 111
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 113
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    invoke-direct {p0, v0, v1, p1}, Lcom/adobe/air/CameraUI;->nativeOnCameraError(JI)V

    .line 115
    iput-wide v2, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 117
    :cond_0
    return-void
.end method

.method private onCameraResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 10
    .param p1, "mediaUri"    # Ljava/lang/String;
    .param p2, "mediaType"    # Ljava/lang/String;
    .param p3, "mediaName"    # Ljava/lang/String;

    .prologue
    const-wide/16 v8, 0x0

    .line 131
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    cmp-long v0, v0, v8

    if-eqz v0, :cond_0

    .line 133
    iget-wide v2, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    move-object v1, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/adobe/air/CameraUI;->nativeOnCameraResult(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 135
    iput-wide v8, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 137
    :cond_0
    return-void
.end method

.method private processImageSuccessResult()V
    .locals 14

    .prologue
    const/4 v13, 0x0

    .line 272
    new-instance v6, Ljava/lang/String;

    const-string v11, "image"

    invoke-direct {v6, v11}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .line 273
    .local v6, "mediaType":Ljava/lang/String;
    new-instance v4, Ljava/io/File;

    iget-object v11, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    invoke-direct {v4, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 274
    .local v4, "f":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v5

    .line 275
    .local v5, "mediaName":Ljava/lang/String;
    const/4 v11, 0x1

    new-array v10, v11, [Ljava/lang/String;

    const/4 v11, 0x0

    iget-object v12, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    aput-object v12, v10, v11

    .line 276
    .local v10, "path":[Ljava/lang/String;
    const/4 v0, 0x0

    .line 277
    .local v0, "bmap":Landroid/graphics/Bitmap;
    const/4 v2, 0x0

    .line 278
    .local v2, "exif":Landroid/media/ExifInterface;
    const-string v7, ""

    .line 280
    .local v7, "orientation":Ljava/lang/String;
    :try_start_0
    new-instance v3, Landroid/media/ExifInterface;

    iget-object v11, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    invoke-direct {v3, v11}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "exif":Landroid/media/ExifInterface;
    .local v3, "exif":Landroid/media/ExifInterface;
    move-object v2, v3

    .line 293
    .end local v3    # "exif":Landroid/media/ExifInterface;
    .restart local v2    # "exif":Landroid/media/ExifInterface;
    :goto_0
    const-string v11, "Orientation"

    invoke-virtual {v2, v11}, Landroid/media/ExifInterface;->getAttribute(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 294
    iget-object v11, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    invoke-static {v11}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 295
    invoke-static {v7}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v11

    invoke-virtual {p0, v0, v11}, Lcom/adobe/air/CameraUI;->rotateBitmap(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 296
    const/4 v8, 0x0

    .line 298
    .local v8, "outStream":Ljava/io/OutputStream;
    :try_start_1
    new-instance v9, Ljava/io/FileOutputStream;

    invoke-direct {v9, v4}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 299
    .end local v8    # "outStream":Ljava/io/OutputStream;
    .local v9, "outStream":Ljava/io/OutputStream;
    if-eqz v0, :cond_0

    .line 300
    :try_start_2
    sget-object v11, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v12, 0x64

    invoke-virtual {v0, v11, v12, v9}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 301
    :cond_0
    invoke-virtual {v9}, Ljava/io/OutputStream;->flush()V

    .line 302
    invoke-virtual {v9}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    move-object v8, v9

    .line 309
    .end local v9    # "outStream":Ljava/io/OutputStream;
    .restart local v8    # "outStream":Ljava/io/OutputStream;
    :goto_1
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v11

    invoke-virtual {v11}, Lcom/adobe/air/AndroidActivityWrapper;->getDefaultContext()Landroid/content/Context;

    move-result-object v11

    .line 308
    invoke-static {v11, v10, v13, v13}, Landroid/media/MediaScannerConnection;->scanFile(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;Landroid/media/MediaScannerConnection$OnScanCompletedListener;)V

    .line 315
    iget-object v11, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    invoke-direct {p0, v11, v6, v5}, Lcom/adobe/air/CameraUI;->onCameraResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 316
    return-void

    .line 281
    .end local v8    # "outStream":Ljava/io/OutputStream;
    :catch_0
    move-exception v1

    .line 282
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0

    .line 303
    .end local v1    # "e":Ljava/io/IOException;
    .restart local v8    # "outStream":Ljava/io/OutputStream;
    :catch_1
    move-exception v1

    .line 304
    .local v1, "e":Ljava/lang/Exception;
    :goto_2
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    .line 303
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v8    # "outStream":Ljava/io/OutputStream;
    .restart local v9    # "outStream":Ljava/io/OutputStream;
    :catch_2
    move-exception v1

    move-object v8, v9

    .end local v9    # "outStream":Ljava/io/OutputStream;
    .restart local v8    # "outStream":Ljava/io/OutputStream;
    goto :goto_2
.end method

.method private processVideoSuccessResult(Landroid/content/Intent;)V
    .locals 14
    .param p1, "data"    # Landroid/content/Intent;

    .prologue
    const/4 v13, 0x2

    .line 364
    const/4 v8, 0x0

    .line 365
    .local v8, "nativePath":Ljava/lang/String;
    const/4 v6, 0x0

    .line 366
    .local v6, "mimeType":Ljava/lang/String;
    const/4 v1, 0x0

    .line 367
    .local v1, "mediaName":Ljava/lang/String;
    const/4 v4, 0x0

    .line 368
    .local v4, "mediaType":Ljava/lang/String;
    const/4 v11, 0x3

    new-array v10, v11, [Ljava/lang/String;

    const/4 v11, 0x0

    const-string v12, "_data"

    aput-object v12, v10, v11

    const/4 v11, 0x1

    const-string v12, "mime_type"

    aput-object v12, v10, v11

    const-string v11, "_display_name"

    aput-object v11, v10, v13

    .line 374
    .local v10, "proj":[Ljava/lang/String;
    invoke-virtual {p1}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v11

    .line 375
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v12

    invoke-virtual {v12}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v12

    .line 373
    invoke-direct {p0, v11, v12, v10}, Lcom/adobe/air/CameraUI;->getCursorFromUri(Landroid/net/Uri;Landroid/app/Activity;[Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v0

    .line 378
    .local v0, "cursor":Landroid/database/Cursor;
    if-eqz v0, :cond_2

    .line 382
    const/4 v9, 0x0

    .local v9, "nativePath_index":I
    const/4 v7, 0x0

    .local v7, "mimeType_index":I
    const/4 v3, 0x0

    .line 383
    .local v3, "mediaName_index":I
    :try_start_0
    const-string v11, "_data"

    invoke-interface {v0, v11}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v9

    .line 384
    const-string v11, "mime_type"

    invoke-interface {v0, v11}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v7

    .line 385
    const-string v11, "_display_name"

    invoke-interface {v0, v11}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v3

    .line 386
    invoke-interface {v0, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 388
    if-eqz v8, :cond_1

    .line 390
    invoke-interface {v0, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6

    .line 391
    invoke-direct {p0, v6}, Lcom/adobe/air/CameraUI;->toMediaType(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 394
    if-nez v4, :cond_0

    .line 396
    new-instance v5, Ljava/lang/String;

    const-string v11, "video"

    invoke-direct {v5, v11}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .end local v4    # "mediaType":Ljava/lang/String;
    .local v5, "mediaType":Ljava/lang/String;
    move-object v4, v5

    .line 399
    .end local v5    # "mediaType":Ljava/lang/String;
    .restart local v4    # "mediaType":Ljava/lang/String;
    :cond_0
    invoke-interface {v0, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 400
    if-nez v1, :cond_1

    .line 402
    new-instance v2, Ljava/lang/String;

    const-string v11, ""

    invoke-direct {v2, v11}, Ljava/lang/String;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v1    # "mediaName":Ljava/lang/String;
    .local v2, "mediaName":Ljava/lang/String;
    move-object v1, v2

    .line 410
    .end local v2    # "mediaName":Ljava/lang/String;
    .restart local v1    # "mediaName":Ljava/lang/String;
    :cond_1
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 411
    const/4 v0, 0x0

    .line 417
    .end local v3    # "mediaName_index":I
    .end local v7    # "mimeType_index":I
    .end local v9    # "nativePath_index":I
    :cond_2
    :goto_0
    if-eqz v4, :cond_3

    const-string v11, "image"

    invoke-virtual {v4, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_4

    :cond_3
    const-string v11, "video"

    invoke-virtual {v4, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_5

    .line 420
    :cond_4
    invoke-direct {p0, v8, v4, v1}, Lcom/adobe/air/CameraUI;->onCameraResult(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 425
    :goto_1
    return-void

    .line 405
    .restart local v3    # "mediaName_index":I
    .restart local v7    # "mimeType_index":I
    .restart local v9    # "nativePath_index":I
    :catch_0
    move-exception v11

    .line 410
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 411
    const/4 v0, 0x0

    .line 412
    goto :goto_0

    .line 410
    :catchall_0
    move-exception v11

    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 411
    const/4 v0, 0x0

    throw v11

    .line 423
    .end local v3    # "mediaName_index":I
    .end local v7    # "mimeType_index":I
    .end local v9    # "nativePath_index":I
    :cond_5
    invoke-direct {p0, v13}, Lcom/adobe/air/CameraUI;->onCameraError(I)V

    goto :goto_1
.end method

.method private stillPictureWork()I
    .locals 15

    .prologue
    const/4 v10, 0x2

    const/16 v14, 0x17

    .line 671
    const/4 v8, 0x0

    .line 672
    .local v8, "rv":I
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v11

    invoke-virtual {v11}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    .line 674
    .local v0, "activity":Landroid/app/Activity;
    if-nez v0, :cond_1

    .line 676
    const/4 v10, 0x4

    .line 769
    :cond_0
    :goto_0
    return v10

    .line 679
    :cond_1
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v11

    invoke-virtual {v11}, Lcom/adobe/air/AndroidActivityWrapper;->GetTargetSdkVersion()I

    move-result v11

    if-lt v11, v14, :cond_2

    sget v11, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ge v11, v14, :cond_3

    :cond_2
    invoke-direct {p0, v0}, Lcom/adobe/air/CameraUI;->getCameraRollDirectory(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v11

    if-eqz v11, :cond_0

    .line 687
    :cond_3
    new-instance v5, Ljava/text/SimpleDateFormat;

    const-string v11, "\'IMG\'_yyyyMMdd_HHmmss"

    invoke-direct {v5, v11}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    .line 688
    .local v5, "fileNameConvention":Ljava/text/SimpleDateFormat;
    new-instance v11, Ljava/util/Date;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    invoke-direct {v11, v12, v13}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v5, v11}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v4

    .line 690
    .local v4, "fileName":Ljava/lang/String;
    const/4 v1, 0x0

    .line 691
    .local v1, "checkFile":Ljava/io/File;
    const/4 v2, 0x0

    .line 692
    .local v2, "checkPath":Ljava/lang/String;
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v11

    invoke-virtual {v11}, Lcom/adobe/air/AndroidActivityWrapper;->GetTargetSdkVersion()I

    move-result v11

    if-lt v11, v14, :cond_6

    sget v11, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v11, v14, :cond_6

    .line 694
    new-instance v9, Ljava/io/File;

    invoke-virtual {v0}, Landroid/app/Activity;->getCacheDir()Ljava/io/File;

    move-result-object v11

    const-string v12, "Pictures"

    invoke-direct {v9, v11, v12}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 695
    .local v9, "storageDir":Ljava/io/File;
    invoke-virtual {v9}, Ljava/io/File;->exists()Z

    move-result v11

    if-nez v11, :cond_4

    .line 697
    invoke-virtual {v9}, Ljava/io/File;->mkdirs()Z

    .line 701
    :cond_4
    :try_start_0
    const-string v11, ".jpg"

    invoke-static {v4, v11, v9}, Ljava/io/File;->createTempFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)Ljava/io/File;

    move-result-object v1

    .line 706
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v2

    .line 723
    .end local v9    # "storageDir":Ljava/io/File;
    :cond_5
    :goto_1
    if-eqz v1, :cond_0

    .line 734
    :try_start_1
    new-instance v6, Landroid/content/Intent;

    const-string v10, "android.media.action.IMAGE_CAPTURE"

    invoke-direct {v6, v10}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 736
    .local v6, "intent":Landroid/content/Intent;
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v10

    invoke-virtual {v10}, Lcom/adobe/air/AndroidActivityWrapper;->GetTargetSdkVersion()I

    move-result v10

    if-lt v10, v14, :cond_7

    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I
    :try_end_1
    .catch Landroid/content/ActivityNotFoundException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/NullPointerException; {:try_start_1 .. :try_end_1} :catch_3

    if-lt v10, v14, :cond_7

    .line 738
    const/4 v7, 0x0

    .line 740
    .local v7, "photoURI":Landroid/net/Uri;
    :try_start_2
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    .line 741
    invoke-virtual {v0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, ".provider"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    .line 740
    invoke-static {v0, v10, v1}, Lcom/adobe/air/CameraUIProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catch Landroid/content/ActivityNotFoundException; {:try_start_2 .. :try_end_2} :catch_2
    .catch Ljava/lang/NullPointerException; {:try_start_2 .. :try_end_2} :catch_3

    move-result-object v7

    .line 747
    :goto_2
    :try_start_3
    const-string v10, "output"

    invoke-virtual {v6, v10, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;

    .line 748
    const/4 v10, 0x2

    invoke-virtual {v6, v10}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 755
    .end local v7    # "photoURI":Landroid/net/Uri;
    :goto_3
    const/4 v10, 0x3

    invoke-virtual {v0, v6, v10}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_3
    .catch Landroid/content/ActivityNotFoundException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/NullPointerException; {:try_start_3 .. :try_end_3} :catch_3

    .line 767
    .end local v6    # "intent":Landroid/content/Intent;
    :goto_4
    iput-object v2, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    move v10, v8

    .line 769
    goto/16 :goto_0

    .line 708
    .restart local v9    # "storageDir":Ljava/io/File;
    :catch_0
    move-exception v3

    .line 711
    .local v3, "e":Ljava/io/IOException;
    const/4 v1, 0x0

    goto :goto_1

    .line 716
    .end local v3    # "e":Ljava/io/IOException;
    .end local v9    # "storageDir":Ljava/io/File;
    :cond_6
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-direct {p0, v0}, Lcom/adobe/air/CameraUI;->getCameraRollDirectory(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, "/"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, ".jpg"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 717
    new-instance v1, Ljava/io/File;

    .end local v1    # "checkFile":Ljava/io/File;
    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 719
    .restart local v1    # "checkFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v11

    if-eqz v11, :cond_5

    .line 720
    const/4 v1, 0x0

    goto :goto_1

    .line 743
    .restart local v6    # "intent":Landroid/content/Intent;
    .restart local v7    # "photoURI":Landroid/net/Uri;
    :catch_1
    move-exception v3

    .line 745
    .local v3, "e":Ljava/lang/Exception;
    :try_start_4
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 756
    .end local v3    # "e":Ljava/lang/Exception;
    .end local v6    # "intent":Landroid/content/Intent;
    .end local v7    # "photoURI":Landroid/net/Uri;
    :catch_2
    move-exception v3

    .line 758
    .local v3, "e":Landroid/content/ActivityNotFoundException;
    const/4 v8, 0x3

    .line 759
    const/4 v2, 0x0

    .line 765
    goto :goto_4

    .line 752
    .end local v3    # "e":Landroid/content/ActivityNotFoundException;
    .restart local v6    # "intent":Landroid/content/Intent;
    :cond_7
    const-string v10, "output"

    invoke-static {v1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object v11

    invoke-virtual {v6, v10, v11}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Parcelable;)Landroid/content/Intent;
    :try_end_4
    .catch Landroid/content/ActivityNotFoundException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/NullPointerException; {:try_start_4 .. :try_end_4} :catch_3

    goto :goto_3

    .line 760
    .end local v6    # "intent":Landroid/content/Intent;
    :catch_3
    move-exception v3

    .line 762
    .local v3, "e":Ljava/lang/NullPointerException;
    const/4 v8, 0x2

    .line 763
    const/4 v2, 0x0

    goto :goto_4
.end method

.method private toMediaType(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "mimeType"    # Ljava/lang/String;

    .prologue
    .line 203
    const/4 v0, 0x0

    .line 205
    .local v0, "mediaType":Ljava/lang/String;
    if-eqz p1, :cond_0

    .line 207
    const-string v1, "image/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 209
    new-instance v0, Ljava/lang/String;

    .end local v0    # "mediaType":Ljava/lang/String;
    const-string v1, "image"

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .line 215
    .restart local v0    # "mediaType":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v0

    .line 210
    :cond_1
    const-string v1, "video/"

    invoke-virtual {p1, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 212
    new-instance v0, Ljava/lang/String;

    .end local v0    # "mediaType":Ljava/lang/String;
    const-string v1, "video"

    invoke-direct {v0, v1}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .restart local v0    # "mediaType":Ljava/lang/String;
    goto :goto_0
.end method

.method private videoCaptureWork()I
    .locals 6

    .prologue
    .line 565
    const/4 v3, 0x0

    .line 568
    .local v3, "rv":I
    :try_start_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    .line 570
    .local v0, "activity":Landroid/app/Activity;
    if-nez v0, :cond_0

    .line 572
    const/4 v3, 0x4

    .line 589
    .end local v0    # "activity":Landroid/app/Activity;
    :goto_0
    return v3

    .line 577
    .restart local v0    # "activity":Landroid/app/Activity;
    :cond_0
    new-instance v2, Landroid/content/Intent;

    const-string v4, "android.media.action.VIDEO_CAPTURE"

    invoke-direct {v2, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 579
    .local v2, "intent":Landroid/content/Intent;
    const-string v4, "android.intent.extra.videoQuality"

    const/4 v5, 0x0

    invoke-virtual {v2, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 582
    const/4 v4, 0x4

    invoke-virtual {v0, v2, v4}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 584
    .end local v0    # "activity":Landroid/app/Activity;
    .end local v2    # "intent":Landroid/content/Intent;
    :catch_0
    move-exception v1

    .line 586
    .local v1, "e":Landroid/content/ActivityNotFoundException;
    const/4 v3, 0x3

    goto :goto_0
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/CloneNotSupportedException;
        }
    .end annotation

    .prologue
    .line 170
    new-instance v0, Ljava/lang/CloneNotSupportedException;

    invoke-direct {v0}, Ljava/lang/CloneNotSupportedException;-><init>()V

    throw v0
.end method

.method public launch(JI)V
    .locals 9
    .param p1, "clientId"    # J
    .param p3, "requestedMediaType"    # I

    .prologue
    const-wide/16 v6, 0x0

    const/4 v4, 0x1

    .line 511
    cmp-long v1, p1, v6

    if-nez v1, :cond_1

    .line 560
    :cond_0
    :goto_0
    return-void

    .line 518
    :cond_1
    iget-boolean v1, p0, Lcom/adobe/air/CameraUI;->mCameraBusy:Z

    if-eqz v1, :cond_2

    .line 522
    invoke-direct {p0, p1, p2, v4}, Lcom/adobe/air/CameraUI;->nativeOnCameraError(JI)V

    goto :goto_0

    .line 528
    :cond_2
    iget-wide v2, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    cmp-long v1, v2, v6

    if-eqz v1, :cond_3

    .line 531
    invoke-direct {p0, v4}, Lcom/adobe/air/CameraUI;->onCameraError(I)V

    .line 534
    :cond_3
    iput-wide p1, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 536
    iput-boolean v4, p0, Lcom/adobe/air/CameraUI;->mCameraBusy:Z

    .line 538
    const/4 v0, 0x0

    .line 539
    .local v0, "cameraResult":I
    packed-switch p3, :pswitch_data_0

    .line 550
    const/4 v0, 0x3

    .line 554
    :goto_1
    if-eqz v0, :cond_0

    .line 557
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/adobe/air/CameraUI;->mCameraBusy:Z

    .line 558
    invoke-direct {p0, v0}, Lcom/adobe/air/CameraUI;->onCameraError(I)V

    goto :goto_0

    .line 542
    :pswitch_0
    invoke-direct {p0}, Lcom/adobe/air/CameraUI;->stillPictureWork()I

    move-result v0

    .line 543
    goto :goto_1

    .line 545
    :pswitch_1
    invoke-direct {p0}, Lcom/adobe/air/CameraUI;->videoCaptureWork()I

    move-result v0

    .line 546
    goto :goto_1

    .line 539
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 7
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x4

    const/4 v5, 0x3

    const/4 v4, 0x0

    .line 439
    if-eq p1, v5, :cond_1

    if-eq p1, v6, :cond_1

    .line 493
    :cond_0
    :goto_0
    return-void

    .line 448
    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/CameraUI;->mCameraBusy:Z

    .line 451
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 458
    packed-switch p2, :pswitch_data_0

    .line 486
    iget-object v0, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    if-eqz v0, :cond_2

    .line 488
    iput-object v4, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    .line 490
    :cond_2
    const/4 v0, 0x2

    invoke-direct {p0, v0}, Lcom/adobe/air/CameraUI;->onCameraError(I)V

    goto :goto_0

    .line 462
    :pswitch_0
    if-ne p1, v5, :cond_4

    .line 464
    iget-object v0, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 466
    invoke-direct {p0}, Lcom/adobe/air/CameraUI;->processImageSuccessResult()V

    .line 467
    iput-object v4, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    goto :goto_0

    .line 471
    :cond_3
    invoke-direct {p0}, Lcom/adobe/air/CameraUI;->onCameraCancel()V

    goto :goto_0

    .line 473
    :cond_4
    if-ne p1, v6, :cond_0

    .line 475
    invoke-direct {p0, p3}, Lcom/adobe/air/CameraUI;->processVideoSuccessResult(Landroid/content/Intent;)V

    goto :goto_0

    .line 479
    :pswitch_1
    iget-object v0, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    if-eqz v0, :cond_5

    .line 481
    iput-object v4, p0, Lcom/adobe/air/CameraUI;->mImagePath:Ljava/lang/String;

    .line 483
    :cond_5
    invoke-direct {p0}, Lcom/adobe/air/CameraUI;->onCameraCancel()V

    goto :goto_0

    .line 458
    nop

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method

.method public rotateBitmap(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
    .locals 9
    .param p1, "bitmap"    # Landroid/graphics/Bitmap;
    .param p2, "orientation"    # I

    .prologue
    const/high16 v4, 0x43340000    # 180.0f

    const/high16 v3, 0x42b40000    # 90.0f

    const/high16 v2, -0x3d4c0000    # -90.0f

    const/high16 v1, 0x3f800000    # 1.0f

    const/high16 v0, -0x40800000    # -1.0f

    .line 320
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 321
    .local v5, "matrix":Landroid/graphics/Matrix;
    packed-switch p2, :pswitch_data_0

    .line 358
    .end local p1    # "bitmap":Landroid/graphics/Bitmap;
    :goto_0
    :pswitch_0
    return-object p1

    .line 325
    .restart local p1    # "bitmap":Landroid/graphics/Bitmap;
    :pswitch_1
    invoke-virtual {v5, v0, v1}, Landroid/graphics/Matrix;->setScale(FF)V

    .line 352
    :goto_1
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p1}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 353
    .local v7, "bmRotated":Landroid/graphics/Bitmap;
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V
    :try_end_0
    .catch Ljava/lang/OutOfMemoryError; {:try_start_0 .. :try_end_0} :catch_0

    move-object p1, v7

    .line 354
    goto :goto_0

    .line 328
    .end local v7    # "bmRotated":Landroid/graphics/Bitmap;
    :pswitch_2
    invoke-virtual {v5, v4}, Landroid/graphics/Matrix;->setRotate(F)V

    goto :goto_1

    .line 331
    :pswitch_3
    invoke-virtual {v5, v4}, Landroid/graphics/Matrix;->setRotate(F)V

    .line 332
    invoke-virtual {v5, v0, v1}, Landroid/graphics/Matrix;->postScale(FF)Z

    goto :goto_1

    .line 335
    :pswitch_4
    invoke-virtual {v5, v3}, Landroid/graphics/Matrix;->setRotate(F)V

    .line 336
    invoke-virtual {v5, v0, v1}, Landroid/graphics/Matrix;->postScale(FF)Z

    goto :goto_1

    .line 339
    :pswitch_5
    invoke-virtual {v5, v3}, Landroid/graphics/Matrix;->setRotate(F)V

    goto :goto_1

    .line 342
    :pswitch_6
    invoke-virtual {v5, v2}, Landroid/graphics/Matrix;->setRotate(F)V

    .line 343
    invoke-virtual {v5, v0, v1}, Landroid/graphics/Matrix;->postScale(FF)Z

    goto :goto_1

    .line 346
    :pswitch_7
    invoke-virtual {v5, v2}, Landroid/graphics/Matrix;->setRotate(F)V

    goto :goto_1

    .line 356
    :catch_0
    move-exception v8

    .line 357
    .local v8, "e":Ljava/lang/OutOfMemoryError;
    invoke-virtual {v8}, Ljava/lang/OutOfMemoryError;->printStackTrace()V

    .line 358
    const/4 p1, 0x0

    goto :goto_0

    .line 321
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
    .end packed-switch
.end method

.method public unregisterCallbacks(J)V
    .locals 3
    .param p1, "clientId"    # J

    .prologue
    .line 191
    iget-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    cmp-long v0, v0, p1

    if-nez v0, :cond_0

    .line 193
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/adobe/air/CameraUI;->mLastClientId:J

    .line 199
    :cond_0
    return-void
.end method
