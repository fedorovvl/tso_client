.class public Lcom/adobe/air/AndroidMediaManager;
.super Ljava/lang/Object;
.source "AndroidMediaManager.java"


# static fields
.field public static final ERROR_ACTIVITY_DESTROYED:I = 0x2

.field public static final ERROR_IMAGE_PICKER_NOT_FOUND:I = 0x1

.field private static MediaManagerObjectPointer:J = 0x0L

.field private static final PHONE_STORAGE:Ljava/lang/String; = "phoneStorage"


# instance fields
.field private mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

.field private mCallbacksRegistered:Z


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidMediaManager;->mCallbacksRegistered:Z

    .line 57
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    .line 75
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    .line 76
    return-void
.end method

.method public static AddImage(Landroid/app/Application;Landroid/graphics/Bitmap;Z)Z
    .locals 12
    .param p0, "app"    # Landroid/app/Application;
    .param p1, "bm"    # Landroid/graphics/Bitmap;
    .param p2, "ignoreAlpha"    # Z

    .prologue
    .line 152
    const/4 v10, 0x0

    .line 153
    .local v10, "retval":Z
    if-eqz p0, :cond_2

    .line 155
    invoke-virtual {p0}, Landroid/app/Application;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 156
    .local v0, "cr":Landroid/content/ContentResolver;
    const/4 v11, 0x0

    .line 161
    .local v11, "str":Ljava/lang/String;
    const/4 v1, 0x0

    const/4 v3, 0x0

    :try_start_0
    invoke-static {v0, p1, v1, v3}, Landroid/provider/MediaStore$Images$Media;->insertImage(Landroid/content/ContentResolver;Landroid/graphics/Bitmap;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v11

    .line 170
    :goto_0
    if-nez v11, :cond_0

    .line 171
    const-string v1, "phoneStorage"

    invoke-static {v1, v0, p1, p2}, Lcom/adobe/air/AndroidMediaManager;->SaveImage(Ljava/lang/String;Landroid/content/ContentResolver;Landroid/graphics/Bitmap;Z)Ljava/lang/String;

    move-result-object v11

    .line 173
    :cond_0
    if-eqz v11, :cond_2

    .line 176
    const/4 v1, 0x1

    :try_start_1
    new-array v2, v1, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v3, "_data"

    aput-object v3, v2, v1

    .line 177
    .local v2, "proj":[Ljava/lang/String;
    invoke-static {v11}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    .line 180
    .local v6, "cursor":Landroid/database/Cursor;
    if-eqz v6, :cond_1

    .line 182
    const-string v1, "_data"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v8

    .line 183
    .local v8, "nativePath_index":I
    invoke-interface {v6}, Landroid/database/Cursor;->moveToFirst()Z

    .line 184
    const/4 v1, 0x1

    new-array v9, v1, [Ljava/lang/String;

    const/4 v1, 0x0

    invoke-interface {v6, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v3

    aput-object v3, v9, v1

    .line 185
    .local v9, "paths":[Ljava/lang/String;
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->getDefaultContext()Landroid/content/Context;

    move-result-object v1

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v1, v9, v3, v4}, Landroid/media/MediaScannerConnection;->scanFile(Landroid/content/Context;[Ljava/lang/String;[Ljava/lang/String;Landroid/media/MediaScannerConnection$OnScanCompletedListener;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 193
    .end local v2    # "proj":[Ljava/lang/String;
    .end local v6    # "cursor":Landroid/database/Cursor;
    .end local v8    # "nativePath_index":I
    .end local v9    # "paths":[Ljava/lang/String;
    :cond_1
    :goto_1
    const/4 v10, 0x1

    .line 197
    .end local v0    # "cr":Landroid/content/ContentResolver;
    .end local v11    # "str":Ljava/lang/String;
    :cond_2
    return v10

    .line 163
    .restart local v0    # "cr":Landroid/content/ContentResolver;
    .restart local v11    # "str":Ljava/lang/String;
    :catch_0
    move-exception v7

    .line 166
    .local v7, "e":Ljava/lang/Exception;
    const/4 v11, 0x0

    goto :goto_0

    .line 189
    .end local v7    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    goto :goto_1
.end method

.method private static SaveImage(Ljava/lang/String;Landroid/content/ContentResolver;Landroid/graphics/Bitmap;Z)Ljava/lang/String;
    .locals 18
    .param p0, "volumeName"    # Ljava/lang/String;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "bm"    # Landroid/graphics/Bitmap;
    .param p3, "ignoreAlpha"    # Z

    .prologue
    .line 205
    const/4 v14, 0x0

    .line 206
    .local v14, "url":Landroid/net/Uri;
    const/4 v13, 0x0

    .line 210
    .local v13, "retval":Ljava/lang/String;
    :try_start_0
    new-instance v15, Landroid/content/ContentValues;

    invoke-direct {v15}, Landroid/content/ContentValues;-><init>()V

    .line 211
    .local v15, "values":Landroid/content/ContentValues;
    if-eqz p3, :cond_2

    .line 212
    const-string v3, "mime_type"

    const-string v4, "image/jpeg"

    invoke-virtual {v15, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 216
    :goto_0
    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    .line 217
    .local v2, "date":Ljava/util/Date;
    const-string v3, "datetaken"

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v8

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-virtual {v15, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 218
    const-string v3, "date_added"

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v8

    const-wide/16 v16, 0x3e8

    div-long v8, v8, v16

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    invoke-virtual {v15, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Long;)V

    .line 221
    invoke-static/range {p0 .. p0}, Landroid/provider/MediaStore$Images$Media;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v3

    move-object/from16 v0, p1

    invoke-virtual {v0, v3, v15}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v14

    .line 224
    if-eqz v14, :cond_0

    .line 226
    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v12

    .line 229
    .local v12, "imageOut":Ljava/io/OutputStream;
    :try_start_1
    sget-object v3, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v4, 0x5a

    move-object/from16 v0, p2

    invoke-virtual {v0, v3, v4, v12}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 232
    invoke-static {v14}, Landroid/content/ContentUris;->parseId(Landroid/net/Uri;)J

    move-result-wide v6

    .line 233
    .local v6, "id":J
    const/high16 v8, 0x43a00000    # 320.0f

    const/high16 v9, 0x43700000    # 240.0f

    const/4 v10, 0x1

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    move-object/from16 v5, p2

    invoke-static/range {v3 .. v10}, Lcom/adobe/air/AndroidMediaManager;->SaveThumbnail(Ljava/lang/String;Landroid/content/ContentResolver;Landroid/graphics/Bitmap;JFFI)Landroid/graphics/Bitmap;

    move-result-object v5

    .line 234
    .local v5, "miniThumb":Landroid/graphics/Bitmap;
    const/high16 v8, 0x42480000    # 50.0f

    const/high16 v9, 0x42480000    # 50.0f

    const/4 v10, 0x3

    move-object/from16 v3, p0

    move-object/from16 v4, p1

    invoke-static/range {v3 .. v10}, Lcom/adobe/air/AndroidMediaManager;->SaveThumbnail(Ljava/lang/String;Landroid/content/ContentResolver;Landroid/graphics/Bitmap;JFFI)Landroid/graphics/Bitmap;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 247
    :try_start_2
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 263
    .end local v2    # "date":Ljava/util/Date;
    .end local v5    # "miniThumb":Landroid/graphics/Bitmap;
    .end local v6    # "id":J
    .end local v12    # "imageOut":Ljava/io/OutputStream;
    .end local v15    # "values":Landroid/content/ContentValues;
    :cond_0
    :goto_1
    if-eqz v14, :cond_1

    .line 264
    invoke-virtual {v14}, Landroid/net/Uri;->toString()Ljava/lang/String;

    move-result-object v13

    .line 266
    :cond_1
    return-object v13

    .line 214
    .restart local v15    # "values":Landroid/content/ContentValues;
    :cond_2
    :try_start_3
    const-string v3, "mime_type"

    const-string v4, "image/png"

    invoke-virtual {v15, v3, v4}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    .line 253
    .end local v15    # "values":Landroid/content/ContentValues;
    :catch_0
    move-exception v11

    .line 256
    .local v11, "e":Ljava/lang/Exception;
    if-eqz v14, :cond_0

    .line 258
    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v14, v3, v4}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 259
    const/4 v14, 0x0

    goto :goto_1

    .line 236
    .end local v11    # "e":Ljava/lang/Exception;
    .restart local v2    # "date":Ljava/util/Date;
    .restart local v12    # "imageOut":Ljava/io/OutputStream;
    .restart local v15    # "values":Landroid/content/ContentValues;
    :catch_1
    move-exception v11

    .line 239
    .restart local v11    # "e":Ljava/lang/Exception;
    if-eqz v14, :cond_3

    .line 241
    const/4 v3, 0x0

    const/4 v4, 0x0

    :try_start_4
    move-object/from16 v0, p1

    invoke-virtual {v0, v14, v3, v4}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 242
    const/4 v14, 0x0

    .line 247
    :cond_3
    :try_start_5
    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    goto :goto_1

    .end local v11    # "e":Ljava/lang/Exception;
    :catchall_0
    move-exception v3

    invoke-virtual {v12}, Ljava/io/OutputStream;->close()V

    throw v3
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
.end method

.method private static final SaveThumbnail(Ljava/lang/String;Landroid/content/ContentResolver;Landroid/graphics/Bitmap;JFFI)Landroid/graphics/Bitmap;
    .locals 17
    .param p0, "volumeName"    # Ljava/lang/String;
    .param p1, "cr"    # Landroid/content/ContentResolver;
    .param p2, "source"    # Landroid/graphics/Bitmap;
    .param p3, "id"    # J
    .param p5, "width"    # F
    .param p6, "height"    # F
    .param p7, "kind"    # I

    .prologue
    .line 271
    if-nez p2, :cond_1

    .line 272
    const/4 v12, 0x0

    .line 324
    :cond_0
    :goto_0
    return-object v12

    .line 274
    :cond_1
    new-instance v7, Landroid/graphics/Matrix;

    invoke-direct {v7}, Landroid/graphics/Matrix;-><init>()V

    .line 275
    .local v7, "matrix":Landroid/graphics/Matrix;
    const/4 v12, 0x0

    .line 279
    .local v12, "thumb":Landroid/graphics/Bitmap;
    :try_start_0
    invoke-virtual/range {p2 .. p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v2

    int-to-float v2, v2

    div-float v10, p5, v2

    .line 280
    .local v10, "scaleX":F
    invoke-virtual/range {p2 .. p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v2

    int-to-float v2, v2

    div-float v11, p6, v2

    .line 282
    .local v11, "scaleY":F
    invoke-virtual {v7, v10, v11}, Landroid/graphics/Matrix;->setScale(FF)V

    .line 284
    const/4 v3, 0x0

    const/4 v4, 0x0

    .line 285
    invoke-virtual/range {p2 .. p2}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    .line 286
    invoke-virtual/range {p2 .. p2}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v6

    const/4 v8, 0x1

    move-object/from16 v2, p2

    .line 284
    invoke-static/range {v2 .. v8}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v12

    .line 295
    new-instance v15, Landroid/content/ContentValues;

    const/4 v2, 0x4

    invoke-direct {v15, v2}, Landroid/content/ContentValues;-><init>(I)V

    .line 296
    .local v15, "values":Landroid/content/ContentValues;
    const-string v2, "kind"

    invoke-static/range {p7 .. p7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v15, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 297
    const-string v2, "image_id"

    move-wide/from16 v0, p3

    long-to-int v3, v0

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v15, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 298
    const-string v2, "height"

    invoke-virtual {v12}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v15, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 299
    const-string v2, "width"

    invoke-virtual {v12}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    invoke-virtual {v15, v2, v3}, Landroid/content/ContentValues;->put(Ljava/lang/String;Ljava/lang/Integer;)V

    .line 301
    const/4 v14, 0x0

    .line 304
    .local v14, "url":Landroid/net/Uri;
    :try_start_1
    invoke-static/range {p0 .. p0}, Landroid/provider/MediaStore$Images$Thumbnails;->getContentUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2, v15}, Landroid/content/ContentResolver;->insert(Landroid/net/Uri;Landroid/content/ContentValues;)Landroid/net/Uri;

    move-result-object v14

    .line 305
    if-eqz v14, :cond_2

    .line 307
    move-object/from16 v0, p1

    invoke-virtual {v0, v14}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v13

    .line 308
    .local v13, "thumbOut":Ljava/io/OutputStream;
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v3, 0x64

    invoke-virtual {v12, v2, v3, v13}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 309
    invoke-virtual {v13}, Ljava/io/OutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 321
    .end local v13    # "thumbOut":Ljava/io/OutputStream;
    :cond_2
    :goto_1
    if-nez v14, :cond_0

    .line 324
    const/4 v12, 0x0

    goto :goto_0

    .line 289
    .end local v10    # "scaleX":F
    .end local v11    # "scaleY":F
    .end local v14    # "url":Landroid/net/Uri;
    .end local v15    # "values":Landroid/content/ContentValues;
    :catch_0
    move-exception v9

    .line 292
    .local v9, "e":Ljava/lang/Exception;
    const/4 v12, 0x0

    goto/16 :goto_0

    .line 312
    .end local v9    # "e":Ljava/lang/Exception;
    .restart local v10    # "scaleX":F
    .restart local v11    # "scaleY":F
    .restart local v14    # "url":Landroid/net/Uri;
    .restart local v15    # "values":Landroid/content/ContentValues;
    :catch_1
    move-exception v9

    .line 315
    .restart local v9    # "e":Ljava/lang/Exception;
    if-eqz v14, :cond_2

    .line 317
    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object/from16 v0, p1

    invoke-virtual {v0, v14, v2, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    .line 318
    const/4 v14, 0x0

    goto :goto_1
.end method

.method static synthetic access$000()J
    .locals 2

    .prologue
    .line 40
    sget-wide v0, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    return-wide v0
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidMediaManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidMediaManager;

    .prologue
    .line 40
    iget-boolean v0, p0, Lcom/adobe/air/AndroidMediaManager;->mCallbacksRegistered:Z

    return v0
.end method

.method private doCallbackRegistration(Z)V
    .locals 2
    .param p1, "register"    # Z

    .prologue
    .line 97
    iput-boolean p1, p0, Lcom/adobe/air/AndroidMediaManager;->mCallbacksRegistered:Z

    .line 98
    if-eqz p1, :cond_2

    .line 100
    iget-object v0, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    if-nez v0, :cond_0

    .line 102
    new-instance v0, Lcom/adobe/air/AndroidMediaManager$1;

    invoke-direct {v0, p0}, Lcom/adobe/air/AndroidMediaManager$1;-><init>(Lcom/adobe/air/AndroidMediaManager;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    .line 137
    :cond_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->addActivityResultListener(Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;)V

    .line 147
    :cond_1
    :goto_0
    return-void

    .line 140
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    if-eqz v0, :cond_1

    .line 142
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->removeActivityResultListener(Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;)V

    .line 143
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidMediaManager;->mActivityResultCB:Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    goto :goto_0
.end method

.method private static rotateImage(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;
    .locals 8
    .param p0, "img"    # Landroid/graphics/Bitmap;
    .param p1, "degree"    # I

    .prologue
    const/4 v1, 0x0

    .line 461
    new-instance v5, Landroid/graphics/Matrix;

    invoke-direct {v5}, Landroid/graphics/Matrix;-><init>()V

    .line 462
    .local v5, "matrix":Landroid/graphics/Matrix;
    int-to-float v0, p1

    invoke-virtual {v5, v0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 463
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p0

    move v2, v1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object v7

    .line 464
    .local v7, "rotatedImg":Landroid/graphics/Bitmap;
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->recycle()V

    .line 465
    return-object v7
.end method


# virtual methods
.method public BrowseImage(J)I
    .locals 7
    .param p1, "platformMediaManagerOperationObject"    # J

    .prologue
    .line 334
    const/4 v2, 0x0

    .line 336
    .local v2, "errorCode":I
    :try_start_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 337
    .local v0, "act":Lcom/adobe/air/AndroidActivityWrapper;
    new-instance v3, Landroid/content/Intent;

    invoke-direct {v3}, Landroid/content/Intent;-><init>()V

    .line 338
    .local v3, "galleryIntent":Landroid/content/Intent;
    const-string v4, "image/*"

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;

    .line 339
    const-string v4, "android.intent.action.PICK"

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 340
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v4

    if-eqz v4, :cond_1

    .line 341
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v4

    const-string v5, ""

    invoke-static {v3, v5}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;

    move-result-object v5

    const/4 v6, 0x2

    invoke-virtual {v4, v5, v6}, Landroid/app/Activity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 350
    .end local v0    # "act":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v3    # "galleryIntent":Landroid/content/Intent;
    :goto_0
    if-nez v2, :cond_0

    .line 352
    invoke-virtual {p0}, Lcom/adobe/air/AndroidMediaManager;->registerCallbacks()V

    .line 353
    sput-wide p1, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    .line 355
    :cond_0
    return v2

    .line 343
    .restart local v0    # "act":Lcom/adobe/air/AndroidActivityWrapper;
    .restart local v3    # "galleryIntent":Landroid/content/Intent;
    :cond_1
    const/4 v2, 0x2

    goto :goto_0

    .line 345
    .end local v0    # "act":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v3    # "galleryIntent":Landroid/content/Intent;
    :catch_0
    move-exception v1

    .line 347
    .local v1, "e":Landroid/content/ActivityNotFoundException;
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public onBrowseImageResult(ILandroid/content/Intent;Landroid/app/Activity;)V
    .locals 24
    .param p1, "resultCode"    # I
    .param p2, "data"    # Landroid/content/Intent;
    .param p3, "act"    # Landroid/app/Activity;

    .prologue
    .line 366
    if-nez p1, :cond_1

    .line 369
    sget-wide v4, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v6, 0x0

    const/4 v7, 0x1

    const-string v8, ""

    const-string v9, ""

    const-string v10, ""

    move-object/from16 v3, p0

    invoke-virtual/range {v3 .. v10}, Lcom/adobe/air/AndroidMediaManager;->useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 457
    :cond_0
    :goto_0
    return-void

    .line 372
    :cond_1
    const/4 v2, -0x1

    move/from16 v0, p1

    if-ne v0, v2, :cond_0

    .line 374
    const/16 v20, 0x0

    .local v20, "nativePath_index":I
    const/16 v18, 0x0

    .line 378
    .local v18, "mediaName_index":I
    const/4 v2, 0x3

    :try_start_0
    new-array v4, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "_data"

    aput-object v3, v4, v2

    const/4 v2, 0x1

    const-string v3, "mime_type"

    aput-object v3, v4, v2

    const/4 v2, 0x2

    const-string v3, "_display_name"

    aput-object v3, v4, v2

    .line 381
    .local v4, "proj":[Ljava/lang/String;
    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getData()Landroid/net/Uri;

    move-result-object v3

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object/from16 v2, p3

    invoke-virtual/range {v2 .. v7}, Landroid/app/Activity;->managedQuery(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v13

    .line 383
    .local v13, "cursor":Landroid/database/Cursor;
    if-nez v13, :cond_2

    .line 386
    sget-wide v6, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-string v10, ""

    const-string v11, ""

    const-string v12, ""

    move-object/from16 v5, p0

    invoke-virtual/range {v5 .. v12}, Lcom/adobe/air/AndroidMediaManager;->useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 394
    .end local v4    # "proj":[Ljava/lang/String;
    .end local v13    # "cursor":Landroid/database/Cursor;
    :catch_0
    move-exception v14

    .line 397
    .local v14, "e":Ljava/lang/IllegalArgumentException;
    sget-wide v6, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-string v10, ""

    const-string v11, ""

    const-string v12, ""

    move-object/from16 v5, p0

    invoke-virtual/range {v5 .. v12}, Lcom/adobe/air/AndroidMediaManager;->useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 390
    .end local v14    # "e":Ljava/lang/IllegalArgumentException;
    .restart local v4    # "proj":[Ljava/lang/String;
    .restart local v13    # "cursor":Landroid/database/Cursor;
    :cond_2
    :try_start_1
    const-string v2, "_data"

    invoke-interface {v13, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v20

    .line 391
    const-string v2, "_display_name"

    invoke-interface {v13, v2}, Landroid/database/Cursor;->getColumnIndexOrThrow(Ljava/lang/String;)I

    move-result v18

    .line 392
    invoke-interface {v13}, Landroid/database/Cursor;->moveToFirst()Z
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 406
    move/from16 v0, v20

    invoke-interface {v13, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v10

    .line 407
    .local v10, "nativePath":Ljava/lang/String;
    new-instance v11, Ljava/lang/String;

    const-string v2, "image"

    invoke-direct {v11, v2}, Ljava/lang/String;-><init>(Ljava/lang/String;)V

    .line 408
    .local v11, "mediaType":Ljava/lang/String;
    move/from16 v0, v18

    invoke-interface {v13, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    .line 410
    .local v12, "mediaName":Ljava/lang/String;
    if-eqz v10, :cond_3

    const-string v2, "http"

    invoke-virtual {v10, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 414
    :cond_3
    sget-wide v6, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v8, 0x1

    const/4 v9, 0x1

    invoke-virtual/range {p2 .. p2}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v10

    .end local v10    # "nativePath":Ljava/lang/String;
    move-object/from16 v5, p0

    invoke-virtual/range {v5 .. v10}, Lcom/adobe/air/AndroidMediaManager;->useStreamData(JZZLjava/lang/String;)V

    goto/16 :goto_0

    .line 399
    .end local v4    # "proj":[Ljava/lang/String;
    .end local v11    # "mediaType":Ljava/lang/String;
    .end local v12    # "mediaName":Ljava/lang/String;
    .end local v13    # "cursor":Landroid/database/Cursor;
    :catch_1
    move-exception v14

    .line 402
    .local v14, "e":Ljava/lang/Exception;
    sget-wide v6, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v8, 0x0

    const/4 v9, 0x0

    const-string v10, ""

    const-string v11, ""

    const-string v12, ""

    move-object/from16 v5, p0

    invoke-virtual/range {v5 .. v12}, Lcom/adobe/air/AndroidMediaManager;->useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 418
    .end local v14    # "e":Ljava/lang/Exception;
    .restart local v4    # "proj":[Ljava/lang/String;
    .restart local v10    # "nativePath":Ljava/lang/String;
    .restart local v11    # "mediaType":Ljava/lang/String;
    .restart local v12    # "mediaName":Ljava/lang/String;
    .restart local v13    # "cursor":Landroid/database/Cursor;
    :cond_4
    invoke-static {v10}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v19

    .line 419
    .local v19, "myBitmap":Landroid/graphics/Bitmap;
    const/4 v15, 0x0

    .line 421
    .local v15, "ei":Landroid/media/ExifInterface;
    :try_start_2
    new-instance v16, Landroid/media/ExifInterface;

    move-object/from16 v0, v16

    invoke-direct {v0, v10}, Landroid/media/ExifInterface;-><init>(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_4

    .end local v15    # "ei":Landroid/media/ExifInterface;
    .local v16, "ei":Landroid/media/ExifInterface;
    move-object/from16 v15, v16

    .line 425
    .end local v16    # "ei":Landroid/media/ExifInterface;
    .restart local v15    # "ei":Landroid/media/ExifInterface;
    :goto_1
    const-string v2, "Orientation"

    const/4 v3, 0x1

    invoke-virtual {v15, v2, v3}, Landroid/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I

    move-result v21

    .line 427
    .local v21, "orientation":I
    packed-switch v21, :pswitch_data_0

    .line 438
    :goto_2
    :pswitch_0
    const/4 v2, 0x1

    move/from16 v0, v21

    if-eq v0, v2, :cond_6

    .line 439
    const/16 v22, 0x0

    .line 440
    .local v22, "out":Ljava/io/FileOutputStream;
    new-instance v17, Ljava/io/File;

    move-object/from16 v0, v17

    invoke-direct {v0, v10}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 443
    .local v17, "file":Ljava/io/File;
    :try_start_3
    new-instance v23, Ljava/io/FileOutputStream;

    move-object/from16 v0, v23

    move-object/from16 v1, v17

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    .line 444
    .end local v22    # "out":Ljava/io/FileOutputStream;
    .local v23, "out":Ljava/io/FileOutputStream;
    if-eqz v19, :cond_5

    .line 445
    :try_start_4
    sget-object v2, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v3, 0x64

    move-object/from16 v0, v19

    move-object/from16 v1, v23

    invoke-virtual {v0, v2, v3, v1}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    .line 446
    :cond_5
    invoke-virtual/range {v23 .. v23}, Ljava/io/FileOutputStream;->flush()V

    .line 447
    invoke-virtual/range {v23 .. v23}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_3

    .line 454
    .end local v17    # "file":Ljava/io/File;
    .end local v23    # "out":Ljava/io/FileOutputStream;
    :cond_6
    :goto_3
    sget-wide v6, Lcom/adobe/air/AndroidMediaManager;->MediaManagerObjectPointer:J

    const/4 v8, 0x1

    const/4 v9, 0x1

    move-object/from16 v5, p0

    invoke-virtual/range {v5 .. v12}, Lcom/adobe/air/AndroidMediaManager;->useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0

    .line 429
    :pswitch_1
    const/16 v2, 0x5a

    move-object/from16 v0, v19

    invoke-static {v0, v2}, Lcom/adobe/air/AndroidMediaManager;->rotateImage(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v19

    .line 430
    goto :goto_2

    .line 432
    :pswitch_2
    const/16 v2, 0xb4

    move-object/from16 v0, v19

    invoke-static {v0, v2}, Lcom/adobe/air/AndroidMediaManager;->rotateImage(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v19

    .line 433
    goto :goto_2

    .line 435
    :pswitch_3
    const/16 v2, 0x10e

    move-object/from16 v0, v19

    invoke-static {v0, v2}, Lcom/adobe/air/AndroidMediaManager;->rotateImage(Landroid/graphics/Bitmap;I)Landroid/graphics/Bitmap;

    move-result-object v19

    goto :goto_2

    .line 448
    .restart local v17    # "file":Ljava/io/File;
    .restart local v22    # "out":Ljava/io/FileOutputStream;
    :catch_2
    move-exception v2

    goto :goto_3

    .end local v22    # "out":Ljava/io/FileOutputStream;
    .restart local v23    # "out":Ljava/io/FileOutputStream;
    :catch_3
    move-exception v2

    move-object/from16 v22, v23

    .end local v23    # "out":Ljava/io/FileOutputStream;
    .restart local v22    # "out":Ljava/io/FileOutputStream;
    goto :goto_3

    .line 422
    .end local v17    # "file":Ljava/io/File;
    .end local v21    # "orientation":I
    .end local v22    # "out":Ljava/io/FileOutputStream;
    :catch_4
    move-exception v2

    goto :goto_1

    .line 427
    :pswitch_data_0
    .packed-switch 0x3
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_1
        :pswitch_0
        :pswitch_3
    .end packed-switch
.end method

.method public registerCallbacks()V
    .locals 1

    .prologue
    .line 83
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidMediaManager;->doCallbackRegistration(Z)V

    .line 84
    return-void
.end method

.method public unregisterCallbacks()V
    .locals 1

    .prologue
    .line 91
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidMediaManager;->doCallbackRegistration(Z)V

    .line 92
    return-void
.end method

.method public native useImagePickerData(JZZLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public native useStreamData(JZZLjava/lang/String;)V
.end method
