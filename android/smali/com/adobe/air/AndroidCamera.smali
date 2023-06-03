.class public Lcom/adobe/air/AndroidCamera;
.super Ljava/lang/Object;
.source "AndroidCamera.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidCamera$PreviewSurfaceCallback;
    }
.end annotation


# static fields
.field private static final CAMERA_POSITION_UNKNOWN:I = -0x1

.field private static final LOG_TAG:Ljava/lang/String; = "AndroidCamera"

.field private static sAreMultipleCamerasSupportedInitialized:Z

.field private static sAreMultipleCamerasSupportedOnDevice:Z

.field private static sCameraInfoClass:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field private static sMIDGetCameraInfo:Ljava/lang/reflect/Method;

.field private static sMIDGetNumberOfCameras:Ljava/lang/reflect/Method;

.field private static sMIDOpen:Ljava/lang/reflect/Method;

.field private static sMIDOpenWithCameraID:Ljava/lang/reflect/Method;


# instance fields
.field private mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

.field private mBuffer1:[B

.field private mBuffer2:[B

.field private mCallbackBuffer:[B

.field private mCallbacksRegistered:Z

.field private mCamera:Landroid/hardware/Camera;

.field private mCameraId:I

.field private mCapturing:Z

.field private mClientId:J

.field private mInitialized:Z

.field private mPreviewSurfaceValid:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    const/4 v0, 0x0

    .line 98
    sput-object v0, Lcom/adobe/air/AndroidCamera;->sCameraInfoClass:Ljava/lang/Class;

    .line 99
    sput-object v0, Lcom/adobe/air/AndroidCamera;->sMIDOpen:Ljava/lang/reflect/Method;

    .line 100
    sput-object v0, Lcom/adobe/air/AndroidCamera;->sMIDOpenWithCameraID:Ljava/lang/reflect/Method;

    .line 101
    sput-object v0, Lcom/adobe/air/AndroidCamera;->sMIDGetNumberOfCameras:Ljava/lang/reflect/Method;

    .line 102
    sput-object v0, Lcom/adobe/air/AndroidCamera;->sMIDGetCameraInfo:Ljava/lang/reflect/Method;

    .line 103
    sput-boolean v1, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    .line 104
    sput-boolean v1, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedInitialized:Z

    return-void
.end method

.method public constructor <init>(J)V
    .locals 5
    .param p1, "clientId"    # J

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x0

    .line 111
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 78
    iput-object v2, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    .line 79
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/adobe/air/AndroidCamera;->mClientId:J

    .line 80
    iput v3, p0, Lcom/adobe/air/AndroidCamera;->mCameraId:I

    .line 81
    iput-boolean v3, p0, Lcom/adobe/air/AndroidCamera;->mInitialized:Z

    .line 82
    iput-boolean v3, p0, Lcom/adobe/air/AndroidCamera;->mCallbacksRegistered:Z

    .line 83
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidCamera;->mPreviewSurfaceValid:Z

    .line 84
    iput-boolean v3, p0, Lcom/adobe/air/AndroidCamera;->mCapturing:Z

    .line 85
    iput-object v2, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    .line 86
    iput-object v2, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    .line 87
    iput-object v2, p0, Lcom/adobe/air/AndroidCamera;->mBuffer1:[B

    .line 88
    iput-object v2, p0, Lcom/adobe/air/AndroidCamera;->mBuffer2:[B

    .line 112
    iput-wide p1, p0, Lcom/adobe/air/AndroidCamera;->mClientId:J

    .line 114
    invoke-static {}, Lcom/adobe/air/AndroidCamera;->areMultipleCamerasSupportedOnDevice()Z

    .line 115
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/AndroidCamera;)J
    .locals 2
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-wide v0, p0, Lcom/adobe/air/AndroidCamera;->mClientId:J

    return-wide v0
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidCamera;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-boolean v0, p0, Lcom/adobe/air/AndroidCamera;->mCallbacksRegistered:Z

    return v0
.end method

.method static synthetic access$200(Lcom/adobe/air/AndroidCamera;J[B)V
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;
    .param p1, "x1"    # J
    .param p3, "x2"    # [B

    .prologue
    .line 73
    invoke-direct {p0, p1, p2, p3}, Lcom/adobe/air/AndroidCamera;->nativeOnFrameCaptured(J[B)V

    return-void
.end method

.method static synthetic access$300(Lcom/adobe/air/AndroidCamera;)[B
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    return-object v0
.end method

.method static synthetic access$302(Lcom/adobe/air/AndroidCamera;[B)[B
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;
    .param p1, "x1"    # [B

    .prologue
    .line 73
    iput-object p1, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    return-object p1
.end method

.method static synthetic access$400(Lcom/adobe/air/AndroidCamera;)[B
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mBuffer1:[B

    return-object v0
.end method

.method static synthetic access$500(Lcom/adobe/air/AndroidCamera;)[B
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mBuffer2:[B

    return-object v0
.end method

.method static synthetic access$600(Lcom/adobe/air/AndroidCamera;)Landroid/hardware/Camera;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    return-object v0
.end method

.method static synthetic access$700(Lcom/adobe/air/AndroidCamera;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;

    .prologue
    .line 73
    iget-boolean v0, p0, Lcom/adobe/air/AndroidCamera;->mPreviewSurfaceValid:Z

    return v0
.end method

.method static synthetic access$702(Lcom/adobe/air/AndroidCamera;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;
    .param p1, "x1"    # Z

    .prologue
    .line 73
    iput-boolean p1, p0, Lcom/adobe/air/AndroidCamera;->mPreviewSurfaceValid:Z

    return p1
.end method

.method static synthetic access$800(Lcom/adobe/air/AndroidCamera;J)V
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;
    .param p1, "x1"    # J

    .prologue
    .line 73
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AndroidCamera;->nativeOnCanOpenCamera(J)V

    return-void
.end method

.method static synthetic access$900(Lcom/adobe/air/AndroidCamera;J)V
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/AndroidCamera;
    .param p1, "x1"    # J

    .prologue
    .line 73
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AndroidCamera;->nativeOnShouldCloseCamera(J)V

    return-void
.end method

.method public static areMultipleCamerasSupportedOnDevice()Z
    .locals 8

    .prologue
    const/4 v7, 0x1

    const/4 v2, 0x0

    .line 121
    sget-boolean v1, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedInitialized:Z

    if-eqz v1, :cond_0

    .line 122
    sget-boolean v1, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    .line 154
    :goto_0
    return v1

    .line 124
    :cond_0
    sput-boolean v7, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedInitialized:Z

    .line 128
    :try_start_0
    const-class v1, Landroid/hardware/Camera;

    const-string v3, "open"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sput-object v1, Lcom/adobe/air/AndroidCamera;->sMIDOpenWithCameraID:Ljava/lang/reflect/Method;

    .line 131
    const-class v3, Landroid/hardware/Camera;

    const-string v4, "getNumberOfCameras"

    const/4 v1, 0x0

    check-cast v1, [Ljava/lang/Class;

    invoke-virtual {v3, v4, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sput-object v1, Lcom/adobe/air/AndroidCamera;->sMIDGetNumberOfCameras:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    .line 140
    :try_start_1
    const-string v1, "android.hardware.Camera$CameraInfo"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Lcom/adobe/air/AndroidCamera;->sCameraInfoClass:Ljava/lang/Class;

    .line 141
    const-class v1, Landroid/hardware/Camera;

    const-string v3, "getCameraInfo"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    sget-object v6, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    sget-object v6, Lcom/adobe/air/AndroidCamera;->sCameraInfoClass:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v1, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sput-object v1, Lcom/adobe/air/AndroidCamera;->sMIDGetCameraInfo:Ljava/lang/reflect/Method;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 148
    sget-object v1, Lcom/adobe/air/AndroidCamera;->sMIDOpenWithCameraID:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/adobe/air/AndroidCamera;->sMIDGetNumberOfCameras:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/adobe/air/AndroidCamera;->sMIDGetCameraInfo:Ljava/lang/reflect/Method;

    if-eqz v1, :cond_1

    .line 150
    sput-boolean v7, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    .line 154
    :cond_1
    sget-boolean v1, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    goto :goto_0

    .line 133
    :catch_0
    move-exception v0

    .local v0, "e":Ljava/lang/NoSuchMethodException;
    move v1, v2

    .line 135
    goto :goto_0

    .line 143
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :catch_1
    move-exception v0

    .local v0, "e":Ljava/lang/Exception;
    move v1, v2

    .line 145
    goto :goto_0
.end method

.method public static getNumberOfCameras()I
    .locals 3

    .prologue
    .line 289
    invoke-static {}, Lcom/adobe/air/AndroidCamera;->areMultipleCamerasSupportedOnDevice()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 292
    :try_start_0
    sget-object v1, Lcom/adobe/air/AndroidCamera;->sMIDGetNumberOfCameras:Ljava/lang/reflect/Method;

    const/4 v2, 0x0

    const/4 v0, 0x0

    check-cast v0, [Ljava/lang/Object;

    invoke-virtual {v1, v2, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 297
    :goto_0
    return v0

    .line 293
    :catch_0
    move-exception v0

    .line 297
    :cond_0
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private native nativeOnCanOpenCamera(J)V
.end method

.method private native nativeOnFrameCaptured(J[B)V
.end method

.method private native nativeOnShouldCloseCamera(J)V
.end method


# virtual methods
.method public autoFocus()Z
    .locals 6

    .prologue
    .line 445
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v4, :cond_0

    iget-boolean v4, p0, Lcom/adobe/air/AndroidCamera;->mCapturing:Z

    if-nez v4, :cond_2

    .line 446
    :cond_0
    const/4 v3, 0x0

    .line 469
    :cond_1
    :goto_0
    return v3

    .line 448
    :cond_2
    const/4 v3, 0x0

    .line 452
    .local v3, "retval":Z
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    .line 453
    .local v2, "params":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v2}, Landroid/hardware/Camera$Parameters;->getFocusMode()Ljava/lang/String;

    move-result-object v1

    .line 456
    .local v1, "focusMode":Ljava/lang/String;
    const-string v4, "fixed"

    if-eq v1, v4, :cond_1

    const-string v4, "infinity"

    if-eq v1, v4, :cond_1

    const-string v4, "continuous-video"

    if-eq v1, v4, :cond_1

    .line 458
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/hardware/Camera;->autoFocus(Landroid/hardware/Camera$AutoFocusCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 460
    const/4 v3, 0x1

    goto :goto_0

    .line 463
    .end local v1    # "focusMode":Ljava/lang/String;
    .end local v2    # "params":Landroid/hardware/Camera$Parameters;
    :catch_0
    move-exception v0

    .line 466
    .local v0, "e":Ljava/lang/Exception;
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public close()V
    .locals 1

    .prologue
    .line 560
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    .line 562
    invoke-virtual {p0}, Lcom/adobe/air/AndroidCamera;->stopCapture()V

    .line 563
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->release()V

    .line 564
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    .line 566
    :cond_0
    return-void
.end method

.method public getCamera()Landroid/hardware/Camera;
    .locals 1

    .prologue
    .line 211
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    return-object v0
.end method

.method public getCameraPosition()I
    .locals 10

    .prologue
    .line 242
    const/4 v3, -0x1

    .line 244
    .local v3, "position":I
    sget-boolean v5, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    if-eqz v5, :cond_2

    .line 246
    const/4 v0, 0x0

    .line 247
    .local v0, "cameraInfo":Ljava/lang/Object;
    const/4 v2, 0x0

    .line 249
    .local v2, "field":Ljava/lang/reflect/Field;
    sget-object v5, Lcom/adobe/air/AndroidCamera;->sCameraInfoClass:Ljava/lang/Class;

    if-eqz v5, :cond_0

    .line 251
    :try_start_0
    sget-object v5, Lcom/adobe/air/AndroidCamera;->sCameraInfoClass:Ljava/lang/Class;

    invoke-virtual {v5}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 260
    .end local v0    # "cameraInfo":Ljava/lang/Object;
    :cond_0
    :try_start_1
    sget-object v5, Lcom/adobe/air/AndroidCamera;->sMIDGetCameraInfo:Ljava/lang/reflect/Method;

    iget-object v6, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    iget v9, p0, Lcom/adobe/air/AndroidCamera;->mCameraId:I

    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    aput-object v9, v7, v8

    const/4 v8, 0x1

    aput-object v0, v7, v8

    invoke-virtual {v5, v6, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 266
    if-eqz v0, :cond_1

    .line 268
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    const-string v6, "facing"

    invoke-virtual {v5, v6}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    move-result-object v2

    .line 276
    :cond_1
    :try_start_3
    invoke-virtual {v2, v0}, Ljava/lang/reflect/Field;->getInt(Ljava/lang/Object;)I
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    move-result v3

    .end local v2    # "field":Ljava/lang/reflect/Field;
    :cond_2
    move v4, v3

    .line 282
    .end local v3    # "position":I
    .local v4, "position":I
    :goto_0
    return v4

    .line 252
    .end local v4    # "position":I
    .restart local v0    # "cameraInfo":Ljava/lang/Object;
    .restart local v2    # "field":Ljava/lang/reflect/Field;
    .restart local v3    # "position":I
    :catch_0
    move-exception v1

    .local v1, "e":Ljava/lang/Exception;
    move v4, v3

    .line 254
    .end local v3    # "position":I
    .restart local v4    # "position":I
    goto :goto_0

    .line 261
    .end local v0    # "cameraInfo":Ljava/lang/Object;
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v4    # "position":I
    .restart local v3    # "position":I
    :catch_1
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    move v4, v3

    .line 263
    .end local v3    # "position":I
    .restart local v4    # "position":I
    goto :goto_0

    .line 269
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v4    # "position":I
    .restart local v3    # "position":I
    :catch_2
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    move v4, v3

    .line 271
    .end local v3    # "position":I
    .restart local v4    # "position":I
    goto :goto_0

    .line 277
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v4    # "position":I
    .restart local v3    # "position":I
    :catch_3
    move-exception v1

    .restart local v1    # "e":Ljava/lang/Exception;
    move v4, v3

    .line 279
    .end local v3    # "position":I
    .restart local v4    # "position":I
    goto :goto_0
.end method

.method public getCaptureFormat()I
    .locals 4

    .prologue
    .line 386
    const/4 v1, 0x0

    .line 389
    .local v1, "format":I
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    .line 390
    .local v2, "params":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v2}, Landroid/hardware/Camera$Parameters;->getPreviewFormat()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    .line 396
    .end local v2    # "params":Landroid/hardware/Camera$Parameters;
    :goto_0
    return v1

    .line 392
    :catch_0
    move-exception v0

    .line 394
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getCaptureHeight()I
    .locals 5

    .prologue
    .line 370
    const/4 v1, 0x0

    .line 373
    .local v1, "height":I
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    .line 374
    .local v2, "params":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v2}, Landroid/hardware/Camera$Parameters;->getPreviewSize()Landroid/hardware/Camera$Size;

    move-result-object v3

    .line 375
    .local v3, "size":Landroid/hardware/Camera$Size;
    iget v1, v3, Landroid/hardware/Camera$Size;->height:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 381
    .end local v2    # "params":Landroid/hardware/Camera$Parameters;
    .end local v3    # "size":Landroid/hardware/Camera$Size;
    :goto_0
    return v1

    .line 377
    :catch_0
    move-exception v0

    .line 379
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public getCaptureWidth()I
    .locals 5

    .prologue
    .line 354
    const/4 v3, 0x0

    .line 357
    .local v3, "width":I
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v1

    .line 358
    .local v1, "params":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v1}, Landroid/hardware/Camera$Parameters;->getPreviewSize()Landroid/hardware/Camera$Size;

    move-result-object v2

    .line 359
    .local v2, "size":Landroid/hardware/Camera$Size;
    iget v3, v2, Landroid/hardware/Camera$Size;->width:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 365
    .end local v1    # "params":Landroid/hardware/Camera$Parameters;
    .end local v2    # "size":Landroid/hardware/Camera$Size;
    :goto_0
    return v3

    .line 361
    :catch_0
    move-exception v0

    .line 363
    .local v0, "e":Ljava/lang/Exception;
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public getSupportedFormats()[I
    .locals 8

    .prologue
    .line 304
    const/4 v6, 0x0

    new-array v5, v6, [I

    .line 307
    .local v5, "retval":[I
    :try_start_0
    iget-object v6, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v6}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v4

    .line 308
    .local v4, "parameters":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v4}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewFormats()Ljava/util/List;

    move-result-object v1

    .line 309
    .local v1, "formatVals":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v6

    new-array v5, v6, [I

    .line 310
    const/4 v2, 0x0

    .line 311
    .local v2, "i":I
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v3, v2

    .end local v2    # "i":I
    .local v3, "i":I
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 314
    .local v0, "format":Ljava/lang/Integer;
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "i":I
    .restart local v2    # "i":I
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v7

    aput v7, v5, v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v3, v2

    .line 315
    .end local v2    # "i":I
    .restart local v3    # "i":I
    goto :goto_0

    .line 317
    .end local v0    # "format":Ljava/lang/Integer;
    .end local v1    # "formatVals":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    .end local v3    # "i":I
    .end local v4    # "parameters":Landroid/hardware/Camera$Parameters;
    :catch_0
    move-exception v6

    .line 322
    :cond_0
    return-object v5
.end method

.method public getSupportedFps()[I
    .locals 8

    .prologue
    .line 218
    const/4 v6, 0x0

    new-array v5, v6, [I

    .line 221
    .local v5, "retval":[I
    :try_start_0
    iget-object v6, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v6}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v4

    .line 222
    .local v4, "parameters":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v4}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewFrameRates()Ljava/util/List;

    move-result-object v1

    .line 223
    .local v1, "fpsVals":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v6

    new-array v5, v6, [I

    .line 224
    const/4 v2, 0x0

    .line 225
    .local v2, "i":I
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v3, v2

    .end local v2    # "i":I
    .local v3, "i":I
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    .line 227
    .local v0, "fps":Ljava/lang/Integer;
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "i":I
    .restart local v2    # "i":I
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v7

    aput v7, v5, v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v3, v2

    .line 228
    .end local v2    # "i":I
    .restart local v3    # "i":I
    goto :goto_0

    .line 230
    .end local v0    # "fps":Ljava/lang/Integer;
    .end local v1    # "fpsVals":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    .end local v3    # "i":I
    .end local v4    # "parameters":Landroid/hardware/Camera$Parameters;
    :catch_0
    move-exception v6

    .line 235
    :cond_0
    return-object v5
.end method

.method public getSupportedVideoSizes()[I
    .locals 8

    .prologue
    .line 329
    const/4 v6, 0x0

    new-array v3, v6, [I

    .line 333
    .local v3, "retval":[I
    :try_start_0
    iget-object v6, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v6}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    .line 334
    .local v2, "parameters":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v2}, Landroid/hardware/Camera$Parameters;->getSupportedPreviewSizes()Ljava/util/List;

    move-result-object v5

    .line 335
    .local v5, "sizes":Ljava/util/List;, "Ljava/util/List<Landroid/hardware/Camera$Size;>;"
    invoke-interface {v5}, Ljava/util/List;->size()I

    move-result v6

    mul-int/lit8 v6, v6, 0x2

    new-array v3, v6, [I

    .line 336
    const/4 v0, 0x0

    .line 337
    .local v0, "i":I
    invoke-interface {v5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v6

    move v1, v0

    .end local v0    # "i":I
    .local v1, "i":I
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/Camera$Size;

    .line 339
    .local v4, "size":Landroid/hardware/Camera$Size;
    add-int/lit8 v0, v1, 0x1

    .end local v1    # "i":I
    .restart local v0    # "i":I
    iget v7, v4, Landroid/hardware/Camera$Size;->width:I

    aput v7, v3, v1

    .line 340
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "i":I
    .restart local v1    # "i":I
    iget v7, v4, Landroid/hardware/Camera$Size;->height:I

    aput v7, v3, v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 343
    .end local v1    # "i":I
    .end local v2    # "parameters":Landroid/hardware/Camera$Parameters;
    .end local v4    # "size":Landroid/hardware/Camera$Size;
    .end local v5    # "sizes":Ljava/util/List;, "Ljava/util/List<Landroid/hardware/Camera$Size;>;"
    :catch_0
    move-exception v6

    .line 348
    :cond_0
    return-object v3
.end method

.method public open(I)Z
    .locals 10
    .param p1, "cameraId"    # I

    .prologue
    const/4 v9, 0x0

    const/4 v3, 0x1

    .line 162
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v4, :cond_1

    .line 206
    :cond_0
    :goto_0
    return v3

    .line 165
    :cond_1
    const/4 v3, 0x0

    .line 166
    .local v3, "retval":Z
    const/4 v2, 0x0

    .line 171
    .local v2, "holder":Landroid/view/SurfaceHolder;
    :try_start_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/AndroidActivityWrapper;->getCameraView()Lcom/adobe/air/AndroidCameraView;

    move-result-object v0

    .line 172
    .local v0, "cameraPreview":Lcom/adobe/air/AndroidCameraView;
    invoke-virtual {v0}, Lcom/adobe/air/AndroidCameraView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    .line 175
    if-eqz v2, :cond_2

    invoke-interface {v2}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v4

    if-eqz v4, :cond_2

    .line 177
    sget-boolean v4, Lcom/adobe/air/AndroidCamera;->sAreMultipleCamerasSupportedOnDevice:Z

    if-eqz v4, :cond_3

    .line 179
    sget-object v4, Lcom/adobe/air/AndroidCamera;->sMIDOpenWithCameraID:Ljava/lang/reflect/Method;

    const/4 v5, 0x0

    const/4 v6, 0x1

    new-array v6, v6, [Ljava/lang/Object;

    const/4 v7, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    aput-object v8, v6, v7

    invoke-virtual {v4, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/hardware/Camera;

    iput-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    .line 180
    iput p1, p0, Lcom/adobe/air/AndroidCamera;->mCameraId:I

    .line 187
    :goto_1
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4, v2}, Landroid/hardware/Camera;->setPreviewDisplay(Landroid/view/SurfaceHolder;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 200
    .end local v0    # "cameraPreview":Lcom/adobe/air/AndroidCameraView;
    :cond_2
    :goto_2
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v4, :cond_0

    .line 202
    new-instance v4, Lcom/adobe/air/AndroidCamera$PreviewSurfaceCallback;

    invoke-direct {v4, p0}, Lcom/adobe/air/AndroidCamera$PreviewSurfaceCallback;-><init>(Lcom/adobe/air/AndroidCamera;)V

    invoke-interface {v2, v4}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 203
    const/4 v3, 0x1

    goto :goto_0

    .line 183
    .restart local v0    # "cameraPreview":Lcom/adobe/air/AndroidCameraView;
    :cond_3
    :try_start_1
    invoke-static {}, Landroid/hardware/Camera;->open()Landroid/hardware/Camera;

    move-result-object v4

    iput-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    .line 184
    const/4 v4, 0x0

    iput v4, p0, Lcom/adobe/air/AndroidCamera;->mCameraId:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    .line 190
    .end local v0    # "cameraPreview":Lcom/adobe/air/AndroidCameraView;
    :catch_0
    move-exception v1

    .line 193
    .local v1, "e":Ljava/lang/Exception;
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v4, :cond_2

    .line 195
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4}, Landroid/hardware/Camera;->release()V

    .line 196
    iput-object v9, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    goto :goto_2
.end method

.method public registerCallbacks(Z)V
    .locals 2
    .param p1, "register"    # Z

    .prologue
    .line 570
    iput-boolean p1, p0, Lcom/adobe/air/AndroidCamera;->mCallbacksRegistered:Z

    .line 571
    if-eqz p1, :cond_1

    .line 573
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    if-nez v0, :cond_0

    .line 575
    new-instance v0, Lcom/adobe/air/AndroidCamera$2;

    invoke-direct {v0, p0}, Lcom/adobe/air/AndroidCamera$2;-><init>(Lcom/adobe/air/AndroidCamera;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    .line 595
    :cond_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->addActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V

    .line 603
    :goto_0
    return-void

    .line 599
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    if-eqz v0, :cond_2

    .line 600
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->removeActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V

    .line 601
    :cond_2
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidCamera;->mActivityStateCB:Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    goto :goto_0
.end method

.method public setContinuousFocusMode()Z
    .locals 5

    .prologue
    .line 403
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-nez v4, :cond_1

    .line 404
    const/4 v3, 0x0

    .line 436
    :cond_0
    :goto_0
    return v3

    .line 406
    :cond_1
    const/4 v3, 0x0

    .line 410
    .local v3, "retval":Z
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v2

    .line 411
    .local v2, "params":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v2}, Landroid/hardware/Camera$Parameters;->getSupportedFocusModes()Ljava/util/List;

    move-result-object v1

    .line 417
    .local v1, "modes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    const-string v4, "continuous-video"

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 419
    const-string v4, "continuous-video"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->setFocusMode(Ljava/lang/String;)V

    .line 420
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4, v2}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 422
    const/4 v3, 0x1

    goto :goto_0

    .line 423
    :cond_2
    const-string v4, "edof"

    invoke-interface {v1, v4}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 424
    const-string v4, "edof"

    invoke-virtual {v2, v4}, Landroid/hardware/Camera$Parameters;->setFocusMode(Ljava/lang/String;)V

    .line 425
    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v4, v2}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 427
    const/4 v3, 0x1

    goto :goto_0

    .line 430
    .end local v1    # "modes":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    .end local v2    # "params":Landroid/hardware/Camera$Parameters;
    :catch_0
    move-exception v0

    .line 433
    .local v0, "e":Ljava/lang/Exception;
    const/4 v3, 0x0

    goto :goto_0
.end method

.method public startCapture(IIII)Z
    .locals 5
    .param p1, "wd"    # I
    .param p2, "ht"    # I
    .param p3, "fps"    # I
    .param p4, "preferredFormat"    # I

    .prologue
    .line 476
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-nez v3, :cond_0

    .line 477
    const/4 v2, 0x0

    .line 542
    :goto_0
    return v2

    .line 479
    :cond_0
    const/4 v2, 0x0

    .line 483
    .local v2, "retval":Z
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v1

    .line 484
    .local v1, "parameters":Landroid/hardware/Camera$Parameters;
    invoke-virtual {v1, p1, p2}, Landroid/hardware/Camera$Parameters;->setPreviewSize(II)V

    .line 485
    invoke-virtual {v1, p3}, Landroid/hardware/Camera$Parameters;->setPreviewFrameRate(I)V

    .line 488
    invoke-virtual {v1, p4}, Landroid/hardware/Camera$Parameters;->setPreviewFormat(I)V

    .line 490
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v3, v1}, Landroid/hardware/Camera;->setParameters(Landroid/hardware/Camera$Parameters;)V

    .line 492
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    new-instance v4, Lcom/adobe/air/AndroidCamera$1;

    invoke-direct {v4, p0}, Lcom/adobe/air/AndroidCamera$1;-><init>(Lcom/adobe/air/AndroidCamera;)V

    invoke-virtual {v3, v4}, Landroid/hardware/Camera;->setPreviewCallbackWithBuffer(Landroid/hardware/Camera$PreviewCallback;)V

    .line 522
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->startPreview()V

    .line 525
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v3}, Landroid/hardware/Camera;->getParameters()Landroid/hardware/Camera$Parameters;

    move-result-object v1

    .line 526
    invoke-virtual {v1}, Landroid/hardware/Camera$Parameters;->getPreviewSize()Landroid/hardware/Camera$Size;

    move-result-object v3

    iget v3, v3, Landroid/hardware/Camera$Size;->width:I

    invoke-virtual {v1}, Landroid/hardware/Camera$Parameters;->getPreviewSize()Landroid/hardware/Camera$Size;

    move-result-object v4

    iget v4, v4, Landroid/hardware/Camera$Size;->height:I

    mul-int/2addr v3, v4

    invoke-virtual {v1}, Landroid/hardware/Camera$Parameters;->getPreviewFormat()I

    move-result v4

    invoke-static {v4}, Landroid/graphics/ImageFormat;->getBitsPerPixel(I)I

    move-result v4

    mul-int v0, v3, v4

    .line 529
    .local v0, "bufferSize":I
    new-array v3, v0, [B

    iput-object v3, p0, Lcom/adobe/air/AndroidCamera;->mBuffer1:[B

    .line 530
    new-array v3, v0, [B

    iput-object v3, p0, Lcom/adobe/air/AndroidCamera;->mBuffer2:[B

    .line 531
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mBuffer1:[B

    iput-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    .line 532
    iget-object v3, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    iget-object v4, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    invoke-virtual {v3, v4}, Landroid/hardware/Camera;->addCallbackBuffer([B)V

    .line 534
    const/4 v2, 0x1

    .line 535
    const/4 v3, 0x1

    iput-boolean v3, p0, Lcom/adobe/air/AndroidCamera;->mCapturing:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 537
    .end local v0    # "bufferSize":I
    .end local v1    # "parameters":Landroid/hardware/Camera$Parameters;
    :catch_0
    move-exception v3

    goto :goto_0
.end method

.method public stopCapture()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 547
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    if-eqz v0, :cond_0

    .line 549
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v0, v1}, Landroid/hardware/Camera;->setPreviewCallback(Landroid/hardware/Camera$PreviewCallback;)V

    .line 550
    iget-object v0, p0, Lcom/adobe/air/AndroidCamera;->mCamera:Landroid/hardware/Camera;

    invoke-virtual {v0}, Landroid/hardware/Camera;->stopPreview()V

    .line 551
    iput-object v1, p0, Lcom/adobe/air/AndroidCamera;->mCallbackBuffer:[B

    .line 552
    iput-object v1, p0, Lcom/adobe/air/AndroidCamera;->mBuffer1:[B

    .line 553
    iput-object v1, p0, Lcom/adobe/air/AndroidCamera;->mBuffer2:[B

    .line 555
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidCamera;->mCapturing:Z

    .line 556
    return-void
.end method
