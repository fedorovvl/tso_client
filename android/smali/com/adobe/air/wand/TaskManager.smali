.class public Lcom/adobe/air/wand/TaskManager;
.super Ljava/lang/Object;
.source "TaskManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/wand/TaskManager$Listener;,
        Lcom/adobe/air/wand/TaskManager$MessageTitle;
    }
.end annotation


# static fields
.field protected static final GESTURE_PHASE_ALL:Ljava/lang/String; = "ALL"

.field protected static final GESTURE_PHASE_BEGIN:Ljava/lang/String; = "BEGIN"

.field protected static final GESTURE_PHASE_END:Ljava/lang/String; = "END"

.field protected static final GESTURE_PHASE_UPDATE:Ljava/lang/String; = "UPDATE"

.field protected static final GESTURE_TYPE_PAN:Ljava/lang/String; = "GESTURE_PAN"

.field protected static final GESTURE_TYPE_ROTATE:Ljava/lang/String; = "GESTURE_ROTATE"

.field protected static final GESTURE_TYPE_SWIPE:Ljava/lang/String; = "GESTURE_SWIPE"

.field protected static final GESTURE_TYPE_TWO_FINGER_TAP:Ljava/lang/String; = "GESTURE_TWO_FINGER_TAP"

.field protected static final GESTURE_TYPE_ZOOM:Ljava/lang/String; = "GESTURE_ZOOM"

.field private static final LOG_TAG:Ljava/lang/String; = "TaskManager"

.field protected static final MOTION_SENSOR_MINIMUM_INTERVAL:I = 0x10

.field protected static final NAME_NOTIFICATION_ACCELEROMETER:Ljava/lang/String; = "accelerometer"

.field protected static final NAME_NOTIFICATION_ACCELEROMETER_DATA:Ljava/lang/String; = "acc"

.field protected static final NAME_NOTIFICATION_DURATION:Ljava/lang/String; = "duration"

.field protected static final NAME_NOTIFICATION_GYROSCOPE:Ljava/lang/String; = "gyroscope"

.field protected static final NAME_NOTIFICATION_GYROSCOPE_DATA:Ljava/lang/String; = "gyro"

.field protected static final NAME_NOTIFICATION_INTERVAL:Ljava/lang/String; = "interval"

.field protected static final NAME_NOTIFICATION_IS_PRIMARY_TOUCH_POINT:Ljava/lang/String; = "isPrimaryTouchPoint"

.field protected static final NAME_NOTIFICATION_IS_TRANSFORM:Ljava/lang/String; = "isTransform"

.field protected static final NAME_NOTIFICATION_LOCAL_X:Ljava/lang/String; = "localX"

.field protected static final NAME_NOTIFICATION_LOCAL_Y:Ljava/lang/String; = "localY"

.field protected static final NAME_NOTIFICATION_MAGNETOMETER:Ljava/lang/String; = "magnetometer"

.field protected static final NAME_NOTIFICATION_MAGNETOMETER_DATA:Ljava/lang/String; = "mag"

.field protected static final NAME_NOTIFICATION_MESSAGE:Ljava/lang/String; = "message"

.field protected static final NAME_NOTIFICATION_OFFSET_X:Ljava/lang/String; = "offsetX"

.field protected static final NAME_NOTIFICATION_OFFSET_Y:Ljava/lang/String; = "offsetY"

.field protected static final NAME_NOTIFICATION_PHASE:Ljava/lang/String; = "phase"

.field protected static final NAME_NOTIFICATION_PRESSURE:Ljava/lang/String; = "pressure"

.field protected static final NAME_NOTIFICATION_ROTATION:Ljava/lang/String; = "rotation"

.field protected static final NAME_NOTIFICATION_SCALE_X:Ljava/lang/String; = "scaleX"

.field protected static final NAME_NOTIFICATION_SCALE_Y:Ljava/lang/String; = "scaleY"

.field protected static final NAME_NOTIFICATION_SCREEN_DIMENSIONS:Ljava/lang/String; = "screenDimensions"

.field protected static final NAME_NOTIFICATION_SIZE_X:Ljava/lang/String; = "sizeX"

.field protected static final NAME_NOTIFICATION_SIZE_Y:Ljava/lang/String; = "sizeY"

.field protected static final NAME_NOTIFICATION_START:Ljava/lang/String; = "start"

.field protected static final NAME_NOTIFICATION_TIMESTAMP:Ljava/lang/String; = "timestamp"

.field protected static final NAME_NOTIFICATION_TOUCH_POINT_ID:Ljava/lang/String; = "touchPointID"

.field protected static final NAME_NOTIFICATION_TYPE:Ljava/lang/String; = "type"

.field protected static final NAME_NOTIFICATION_VIBRATOR:Ljava/lang/String; = "vibrator"

.field protected static final SCREEN_DIMENSIONS_HEIGHT:Ljava/lang/String; = "height"

.field protected static final SCREEN_DIMENSIONS_WIDTH:Ljava/lang/String; = "width"

.field protected static final TOUCH_TYPE_BEGIN:Ljava/lang/String; = "TOUCH_BEGIN"

.field protected static final TOUCH_TYPE_END:Ljava/lang/String; = "TOUCH_END"

.field protected static final TOUCH_TYPE_MOVE:Ljava/lang/String; = "TOUCH_MOVE"


# instance fields
.field private final mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

.field private final mDisplay:Landroid/view/Display;

.field private final mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

.field private mListener:Lcom/adobe/air/wand/TaskManager$Listener;

.field private final mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

.field private final mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

.field private final mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

.field private final mVibrator:Landroid/os/Vibrator;


# direct methods
.method public constructor <init>(Lcom/adobe/air/wand/message/MessageManager;Landroid/view/Display;Lcom/adobe/air/wand/view/TouchSensor;Lcom/adobe/air/wand/motionsensor/Accelerometer;Lcom/adobe/air/wand/motionsensor/Magnetometer;Lcom/adobe/air/wand/motionsensor/Gyroscope;Landroid/os/Vibrator;)V
    .locals 2
    .param p1, "messageManager"    # Lcom/adobe/air/wand/message/MessageManager;
    .param p2, "display"    # Landroid/view/Display;
    .param p3, "touchSensor"    # Lcom/adobe/air/wand/view/TouchSensor;
    .param p4, "accelerometer"    # Lcom/adobe/air/wand/motionsensor/Accelerometer;
    .param p5, "magnetometer"    # Lcom/adobe/air/wand/motionsensor/Magnetometer;
    .param p6, "gyroscope"    # Lcom/adobe/air/wand/motionsensor/Gyroscope;
    .param p7, "vibrator"    # Landroid/os/Vibrator;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 177
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 161
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    .line 179
    if-nez p1, :cond_0

    .line 181
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid MessageManager"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 183
    :cond_0
    iput-object p1, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    .line 185
    if-nez p4, :cond_1

    .line 187
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid Accelerometer"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 189
    :cond_1
    iput-object p4, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    .line 191
    if-nez p5, :cond_2

    .line 193
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid Magnetometer"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 195
    :cond_2
    iput-object p5, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    .line 197
    if-nez p6, :cond_3

    .line 199
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid Gyroscope"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 201
    :cond_3
    iput-object p6, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    .line 204
    iput-object p7, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    .line 206
    if-nez p2, :cond_4

    .line 208
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid Display"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 210
    :cond_4
    iput-object p2, p0, Lcom/adobe/air/wand/TaskManager;->mDisplay:Landroid/view/Display;

    .line 212
    if-nez p3, :cond_5

    .line 214
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid TouchSensor"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 216
    :cond_5
    iput-object p3, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    .line 218
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    new-instance v1, Lcom/adobe/air/wand/TaskManager$1;

    invoke-direct {v1, p0}, Lcom/adobe/air/wand/TaskManager$1;-><init>(Lcom/adobe/air/wand/TaskManager;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/view/TouchSensor;->setListener(Lcom/adobe/air/wand/view/TouchSensor$Listener;)V

    .line 233
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    new-instance v1, Lcom/adobe/air/wand/TaskManager$2;

    invoke-direct {v1, p0}, Lcom/adobe/air/wand/TaskManager$2;-><init>(Lcom/adobe/air/wand/TaskManager;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V

    .line 242
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    new-instance v1, Lcom/adobe/air/wand/TaskManager$3;

    invoke-direct {v1, p0}, Lcom/adobe/air/wand/TaskManager$3;-><init>(Lcom/adobe/air/wand/TaskManager;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V

    .line 251
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    new-instance v1, Lcom/adobe/air/wand/TaskManager$4;

    invoke-direct {v1, p0}, Lcom/adobe/air/wand/TaskManager$4;-><init>(Lcom/adobe/air/wand/TaskManager;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->setListener(Lcom/adobe/air/wand/motionsensor/MotionSensor$Listener;)V

    .line 259
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/wand/TaskManager;Lcom/adobe/air/TouchEventData;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/TaskManager;
    .param p1, "x1"    # Lcom/adobe/air/TouchEventData;

    .prologue
    .line 60
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->sendTouchEventData(Lcom/adobe/air/TouchEventData;)V

    return-void
.end method

.method static synthetic access$100(Lcom/adobe/air/wand/TaskManager;Lcom/adobe/air/wand/view/GestureEventData;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/TaskManager;
    .param p1, "x1"    # Lcom/adobe/air/wand/view/GestureEventData;

    .prologue
    .line 60
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->sendGestureEventData(Lcom/adobe/air/wand/view/GestureEventData;)V

    return-void
.end method

.method static synthetic access$200(Lcom/adobe/air/wand/TaskManager;[FJLjava/lang/String;Lcom/adobe/air/wand/TaskManager$MessageTitle;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/wand/TaskManager;
    .param p1, "x1"    # [F
    .param p2, "x2"    # J
    .param p4, "x3"    # Ljava/lang/String;
    .param p5, "x4"    # Lcom/adobe/air/wand/TaskManager$MessageTitle;

    .prologue
    .line 60
    invoke-direct/range {p0 .. p5}, Lcom/adobe/air/wand/TaskManager;->sendMotionSensorData([FJLjava/lang/String;Lcom/adobe/air/wand/TaskManager$MessageTitle;)V

    return-void
.end method

.method private getGesturePhases(I)[Ljava/lang/String;
    .locals 2
    .param p1, "gesturePhase"    # I

    .prologue
    .line 263
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 265
    .local v0, "types":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    and-int/lit8 v1, p1, 0x2

    if-eqz v1, :cond_0

    .line 267
    const-string v1, "BEGIN"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 270
    :cond_0
    and-int/lit8 v1, p1, 0x1

    if-eqz v1, :cond_1

    .line 272
    const-string v1, "UPDATE"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 275
    :cond_1
    and-int/lit8 v1, p1, 0x4

    if-eqz v1, :cond_2

    .line 277
    const-string v1, "END"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 280
    :cond_2
    and-int/lit8 v1, p1, 0x8

    if-eqz v1, :cond_3

    .line 282
    const-string v1, "ALL"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 285
    :cond_3
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    return-object v1
.end method

.method private getTouchTypes(I)[Ljava/lang/String;
    .locals 2
    .param p1, "touchType"    # I

    .prologue
    .line 342
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 344
    .local v0, "types":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    and-int/lit8 v1, p1, 0x2

    if-eqz v1, :cond_0

    .line 346
    const-string v1, "TOUCH_BEGIN"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 349
    :cond_0
    and-int/lit8 v1, p1, 0x1

    if-eqz v1, :cond_1

    .line 351
    const-string v1, "TOUCH_MOVE"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 354
    :cond_1
    and-int/lit8 v1, p1, 0x4

    if-eqz v1, :cond_2

    .line 356
    const-string v1, "TOUCH_END"

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 359
    :cond_2
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    return-object v1
.end method

.method private handleDrawImageRequest(Lcom/adobe/air/wand/message/Request;)V
    .locals 10
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;

    .prologue
    const/4 v9, -0x1

    .line 873
    :try_start_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Request;->getData()Lcom/adobe/air/wand/message/Request$Data;

    move-result-object v7

    invoke-virtual {v7}, Lcom/adobe/air/wand/message/Request$Data;->getArguments()Lcom/adobe/air/wand/message/MessageDataArray;

    move-result-object v0

    .line 876
    .local v0, "args":Lcom/adobe/air/wand/message/MessageDataArray;
    const/4 v7, 0x0

    invoke-interface {v0, v7}, Lcom/adobe/air/wand/message/MessageDataArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 878
    .local v1, "base64Image":Ljava/lang/String;
    const/4 v7, 0x0

    invoke-static {v1, v7}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v5

    .line 881
    .local v5, "imageData":[B
    array-length v7, v5

    const/4 v8, 0x4

    if-lt v7, v8, :cond_0

    const/4 v7, 0x0

    aget-byte v7, v5, v7

    if-ne v7, v9, :cond_0

    const/4 v7, 0x1

    aget-byte v7, v5, v7

    const/16 v8, -0x28

    if-ne v7, v8, :cond_0

    const/4 v7, 0x2

    aget-byte v7, v5, v7

    if-eq v7, v9, :cond_2

    .line 886
    :cond_0
    new-instance v7, Ljava/lang/Exception;

    const-string v8, "Unsupported image format"

    invoke-direct {v7, v8}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v7
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 902
    .end local v0    # "args":Lcom/adobe/air/wand/message/MessageDataArray;
    .end local v1    # "base64Image":Ljava/lang/String;
    .end local v5    # "imageData":[B
    :catch_0
    move-exception v2

    .line 905
    .local v2, "e":Ljava/lang/Exception;
    :try_start_1
    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, p1, v8}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedErrorResponse(Lcom/adobe/air/wand/message/Request;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 907
    .local v6, "serializedResponse":Ljava/lang/String;
    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v7, :cond_1

    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v7, v6}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 916
    .end local v2    # "e":Ljava/lang/Exception;
    .end local v6    # "serializedResponse":Ljava/lang/String;
    :cond_1
    :goto_0
    return-void

    .line 889
    .restart local v0    # "args":Lcom/adobe/air/wand/message/MessageDataArray;
    .restart local v1    # "base64Image":Ljava/lang/String;
    .restart local v5    # "imageData":[B
    :cond_2
    const/4 v7, 0x0

    :try_start_2
    array-length v8, v5

    invoke-static {v5, v7, v8}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 891
    .local v4, "image":Landroid/graphics/Bitmap;
    if-nez v4, :cond_3

    new-instance v7, Ljava/lang/Exception;

    const-string v8, "Unable to decode the image"

    invoke-direct {v7, v8}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v7

    .line 894
    :cond_3
    const/4 v5, 0x0

    .line 896
    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v7, :cond_4

    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v7, v4}, Lcom/adobe/air/wand/TaskManager$Listener;->drawImage(Landroid/graphics/Bitmap;)V

    .line 898
    :cond_4
    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v7, p1}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedSuccessResponse(Lcom/adobe/air/wand/message/Request;)Ljava/lang/String;

    move-result-object v6

    .line 900
    .restart local v6    # "serializedResponse":Ljava/lang/String;
    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v7, :cond_1

    iget-object v7, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v7, v6}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    .line 909
    .end local v0    # "args":Lcom/adobe/air/wand/message/MessageDataArray;
    .end local v1    # "base64Image":Ljava/lang/String;
    .end local v4    # "image":Landroid/graphics/Bitmap;
    .end local v5    # "imageData":[B
    .end local v6    # "serializedResponse":Ljava/lang/String;
    .restart local v2    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v3

    .line 911
    .local v3, "ex":Ljava/lang/Exception;
    const-string v7, "Invalid DRAW_IMAGE request"

    invoke-direct {p0, v7}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleHardwareSpecsRequest(Lcom/adobe/air/wand/message/Request;)V
    .locals 13
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;

    .prologue
    .line 796
    :try_start_0
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v11}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v4

    .line 798
    .local v4, "hardwareSpecsData":Lcom/adobe/air/wand/message/MessageDataObject;
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v11}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->available()Z

    move-result v5

    .line 799
    .local v5, "hasAccelerometer":Z
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v11}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->available()Z

    move-result v7

    .line 800
    .local v7, "hasMagnetometer":Z
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v11}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->available()Z

    move-result v6

    .line 802
    .local v6, "hasGyroscope":Z
    iget-object v1, p0, Lcom/adobe/air/wand/TaskManager;->mDisplay:Landroid/view/Display;

    .line 804
    .local v1, "display":Landroid/view/Display;
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v11}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 805
    .local v0, "dataObj":Lcom/adobe/air/wand/message/MessageDataObject;
    invoke-virtual {v1}, Landroid/view/Display;->getWidth()I

    move-result v10

    .line 806
    .local v10, "width":I
    invoke-virtual {v1}, Landroid/view/Display;->getHeight()I

    move-result v8

    .line 808
    .local v8, "height":I
    const-string v11, "width"

    invoke-interface {v0, v11, v10}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;I)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 809
    const-string v11, "height"

    invoke-interface {v0, v11, v8}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;I)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 811
    const-string v11, "screenDimensions"

    invoke-interface {v4, v11, v0}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 812
    const-string v11, "accelerometer"

    invoke-interface {v4, v11, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 813
    const-string v11, "vibrator"

    invoke-direct {p0}, Lcom/adobe/air/wand/TaskManager;->hasVibrator()Z

    move-result v12

    invoke-interface {v4, v11, v12}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 815
    invoke-direct {p0}, Lcom/adobe/air/wand/TaskManager;->isOrAboveV1_1_0()Z

    move-result v11

    if-eqz v11, :cond_0

    .line 817
    const-string v11, "magnetometer"

    invoke-interface {v4, v11, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 818
    const-string v11, "gyroscope"

    invoke-interface {v4, v11, v6}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 821
    :cond_0
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    sget-object v12, Lcom/adobe/air/wand/message/Response$Status;->SUCCESS:Lcom/adobe/air/wand/message/Response$Status;

    invoke-virtual {v11, p1, v12, v4}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedResponse(Lcom/adobe/air/wand/message/Request;Lcom/adobe/air/wand/message/Response$Status;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;

    move-result-object v9

    .line 823
    .local v9, "serializedResponse":Ljava/lang/String;
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v11, :cond_1

    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v11, v9}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 839
    .end local v0    # "dataObj":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v1    # "display":Landroid/view/Display;
    .end local v4    # "hardwareSpecsData":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v5    # "hasAccelerometer":Z
    .end local v6    # "hasGyroscope":Z
    .end local v7    # "hasMagnetometer":Z
    .end local v8    # "height":I
    .end local v9    # "serializedResponse":Ljava/lang/String;
    .end local v10    # "width":I
    :cond_1
    :goto_0
    return-void

    .line 825
    :catch_0
    move-exception v2

    .line 828
    .local v2, "e":Ljava/lang/Exception;
    :try_start_1
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, p1, v12}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedErrorResponse(Lcom/adobe/air/wand/message/Request;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 830
    .restart local v9    # "serializedResponse":Ljava/lang/String;
    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v11, :cond_1

    iget-object v11, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v11, v9}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 832
    .end local v9    # "serializedResponse":Ljava/lang/String;
    :catch_1
    move-exception v3

    .line 834
    .local v3, "ex":Ljava/lang/Exception;
    const-string v11, "Invalid HARDWARE_SPECIFICATIONS request"

    invoke-direct {p0, v11}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleRemoteAccelerometerEventNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 4
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 584
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->available()Z

    move-result v3

    if-nez v3, :cond_0

    .line 586
    const-string v3, "The device does not have an accelerometer"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    .line 624
    :goto_0
    return-void

    .line 590
    :cond_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v3

    invoke-virtual {v3}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 592
    .local v2, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v3, "start"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 594
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->active()Z

    move-result v3

    if-nez v3, :cond_2

    .line 596
    const-string v3, "interval"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 597
    .local v1, "interval":I
    const/16 v3, 0x10

    if-ge v1, v3, :cond_1

    const/16 v1, 0x10

    .line 599
    :cond_1
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v3, v1}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->start(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 618
    .end local v1    # "interval":I
    .end local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v0

    .line 620
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "Invalid ACCELEROMETER_EVENT notification"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 603
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_2
    :try_start_1
    const-string v3, "Already started accelerometer event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 608
    :cond_3
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->active()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 610
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->stop()V

    goto :goto_0

    .line 614
    :cond_4
    const-string v3, "Already stopped accelerometer event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private handleRemoteGestureNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 3
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 754
    :try_start_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 756
    .local v1, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v2, "start"

    invoke-interface {v1, v2}, Lcom/adobe/air/wand/message/MessageDataObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 758
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->activeGestureListening()Z

    move-result v2

    if-nez v2, :cond_0

    .line 760
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->startGestureEventListening()V

    .line 784
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :goto_0
    return-void

    .line 764
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_0
    const-string v2, "Already started gesture event updates"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 778
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v0

    .line 780
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Invalid GESTURE_EVENT notification"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 769
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->activeGestureListening()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 771
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->stopGestureEventListening()V

    goto :goto_0

    .line 775
    :cond_2
    const-string v2, "Already stopped gesture event updates"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private handleRemoteGyroscopeEventNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 4
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 674
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->available()Z

    move-result v3

    if-nez v3, :cond_0

    .line 676
    const-string v3, "The device does not have a gyroscope"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    .line 714
    :goto_0
    return-void

    .line 680
    :cond_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v3

    invoke-virtual {v3}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 682
    .local v2, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v3, "start"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 684
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->active()Z

    move-result v3

    if-nez v3, :cond_2

    .line 686
    const-string v3, "interval"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 687
    .local v1, "interval":I
    const/16 v3, 0x10

    if-ge v1, v3, :cond_1

    const/16 v1, 0x10

    .line 689
    :cond_1
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v3, v1}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->start(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 708
    .end local v1    # "interval":I
    .end local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v0

    .line 710
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "Invalid GYROSCOPE_EVENT notification"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 693
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_2
    :try_start_1
    const-string v3, "Already started gyroscope event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 698
    :cond_3
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->active()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 700
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->stop()V

    goto :goto_0

    .line 704
    :cond_4
    const-string v3, "Already stopped gyroscope event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private handleRemoteMagnetometerEventNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 4
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 629
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->available()Z

    move-result v3

    if-nez v3, :cond_0

    .line 631
    const-string v3, "The device does not have an magnetometer"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    .line 669
    :goto_0
    return-void

    .line 635
    :cond_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v3

    invoke-virtual {v3}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 637
    .local v2, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v3, "start"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 639
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->active()Z

    move-result v3

    if-nez v3, :cond_2

    .line 641
    const-string v3, "interval"

    invoke-interface {v2, v3}, Lcom/adobe/air/wand/message/MessageDataObject;->getInt(Ljava/lang/String;)I

    move-result v1

    .line 642
    .local v1, "interval":I
    const/16 v3, 0x10

    if-ge v1, v3, :cond_1

    const/16 v1, 0x10

    .line 644
    :cond_1
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v3, v1}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->start(I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 663
    .end local v1    # "interval":I
    .end local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v0

    .line 665
    .local v0, "e":Ljava/lang/Exception;
    const-string v3, "Invalid MAGNETOMETER_EVENT notification"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 648
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v2    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_2
    :try_start_1
    const-string v3, "Already started magnetometer event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 653
    :cond_3
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->active()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 655
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v3}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->stop()V

    goto :goto_0

    .line 659
    :cond_4
    const-string v3, "Already stopped magnetometer event updates"

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private handleRemoteNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 3
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 519
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getHeader()Lcom/adobe/air/wand/message/Notification$Header;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/wand/message/Notification$Header;->getTitle()Ljava/lang/String;

    move-result-object v0

    .line 521
    .local v0, "title":Ljava/lang/String;
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->VIBRATE:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 523
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteVibrateNotification(Lcom/adobe/air/wand/message/Notification;)V

    .line 549
    :goto_0
    return-void

    .line 525
    :cond_0
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->ACCELEROMETER_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 527
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteAccelerometerEventNotification(Lcom/adobe/air/wand/message/Notification;)V

    goto :goto_0

    .line 529
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/wand/TaskManager;->isOrAboveV1_1_0()Z

    move-result v1

    if-eqz v1, :cond_2

    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->MAGNETOMETER_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 531
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteMagnetometerEventNotification(Lcom/adobe/air/wand/message/Notification;)V

    goto :goto_0

    .line 533
    :cond_2
    invoke-direct {p0}, Lcom/adobe/air/wand/TaskManager;->isOrAboveV1_1_0()Z

    move-result v1

    if-eqz v1, :cond_3

    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->GYROSCOPE_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 535
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteGyroscopeEventNotification(Lcom/adobe/air/wand/message/Notification;)V

    goto :goto_0

    .line 537
    :cond_3
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->TOUCH_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 539
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteTouchNotification(Lcom/adobe/air/wand/message/Notification;)V

    goto :goto_0

    .line 541
    :cond_4
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->GESTURE_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 543
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleRemoteGestureNotification(Lcom/adobe/air/wand/message/Notification;)V

    goto :goto_0

    .line 547
    :cond_5
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported NOTIFICATION title : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleRemoteRequest(Lcom/adobe/air/wand/message/Request;)V
    .locals 3
    .param p1, "request"    # Lcom/adobe/air/wand/message/Request;

    .prologue
    .line 488
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Request;->getHeader()Lcom/adobe/air/wand/message/Request$Header;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/wand/message/Request$Header;->getTitle()Ljava/lang/String;

    move-result-object v0

    .line 490
    .local v0, "title":Ljava/lang/String;
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->DRAW_IMAGE:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 492
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleDrawImageRequest(Lcom/adobe/air/wand/message/Request;)V

    .line 502
    :goto_0
    return-void

    .line 494
    :cond_0
    sget-object v1, Lcom/adobe/air/wand/TaskManager$MessageTitle;->HARDWARE_SPECIFICATIONS:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v1}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 496
    invoke-direct {p0, p1}, Lcom/adobe/air/wand/TaskManager;->handleHardwareSpecsRequest(Lcom/adobe/air/wand/message/Request;)V

    goto :goto_0

    .line 500
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported REQUEST title : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0
.end method

.method private handleRemoteResponse(Lcom/adobe/air/wand/message/Response;)V
    .locals 3
    .param p1, "response"    # Lcom/adobe/air/wand/message/Response;

    .prologue
    .line 506
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Response;->getHeader()Lcom/adobe/air/wand/message/Response$Header;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/wand/message/Response$Header;->getTitle()Ljava/lang/String;

    move-result-object v0

    .line 508
    .local v0, "title":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unsupported RESPONSE title : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    .line 511
    return-void
.end method

.method private handleRemoteTouchNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 3
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 719
    :try_start_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v2

    invoke-virtual {v2}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 721
    .local v1, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v2, "start"

    invoke-interface {v1, v2}, Lcom/adobe/air/wand/message/MessageDataObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 723
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->activeTouchListening()Z

    move-result v2

    if-nez v2, :cond_0

    .line 725
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->startTouchEventListening()V

    .line 749
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :goto_0
    return-void

    .line 729
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_0
    const-string v2, "Already started touch event updates"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 743
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v0

    .line 745
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Invalid TOUCH_EVENT notification"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 734
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->activeTouchListening()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 736
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v2}, Lcom/adobe/air/wand/view/TouchSensor;->stopTouchEventListening()V

    goto :goto_0

    .line 740
    :cond_2
    const-string v2, "Already stopped touch event updates"

    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private handleRemoteVibrateNotification(Lcom/adobe/air/wand/message/Notification;)V
    .locals 6
    .param p1, "notification"    # Lcom/adobe/air/wand/message/Notification;

    .prologue
    .line 843
    :try_start_0
    invoke-virtual {p1}, Lcom/adobe/air/wand/message/Notification;->getData()Lcom/adobe/air/wand/message/Notification$Data;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/Notification$Data;->getNotification()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/adobe/air/wand/message/MessageDataObject;

    .line 846
    .local v1, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v4, "duration"

    invoke-interface {v1, v4}, Lcom/adobe/air/wand/message/MessageDataObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    .line 848
    .local v2, "vibrateDuration":J
    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-gtz v4, :cond_0

    .line 850
    const-string v4, "Invalid vibrate duration."

    invoke-direct {p0, v4}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    .line 869
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v2    # "vibrateDuration":J
    :goto_0
    return-void

    .line 854
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    .restart local v2    # "vibrateDuration":J
    :cond_0
    invoke-direct {p0}, Lcom/adobe/air/wand/TaskManager;->hasVibrator()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 856
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    invoke-virtual {v4, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 863
    .end local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v2    # "vibrateDuration":J
    :catch_0
    move-exception v0

    .line 865
    .local v0, "e":Ljava/lang/Exception;
    const-string v4, "Invalid VIBRATE notification"

    invoke-direct {p0, v4}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 860
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    .restart local v2    # "vibrateDuration":J
    :cond_1
    :try_start_1
    const-string v4, "Device does not support vibration"

    invoke-direct {p0, v4}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0
.end method

.method private hasVibrator()Z
    .locals 2

    .prologue
    .line 788
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->hasVibrator()Z

    move-result v0

    .line 790
    :goto_0
    return v0

    :cond_0
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private isOrAboveV1_1_0()Z
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 515
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v0}, Lcom/adobe/air/wand/TaskManager$Listener;->getRequestedProtocolVerison()Ljava/lang/String;

    move-result-object v0

    const-string v1, "1.1.0"

    invoke-static {v0, v1}, Lcom/adobe/air/wand/Version;->isGreaterThanEqualTo(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private sendGestureEventData(Lcom/adobe/air/wand/view/GestureEventData;)V
    .locals 8
    .param p1, "gestureEvent"    # Lcom/adobe/air/wand/view/GestureEventData;

    .prologue
    .line 290
    iget v4, p1, Lcom/adobe/air/wand/view/GestureEventData;->mPhase:I

    invoke-direct {p0, v4}, Lcom/adobe/air/wand/TaskManager;->getGesturePhases(I)[Ljava/lang/String;

    move-result-object v1

    .line 292
    .local v1, "gesturePhases":[Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v4, v1

    if-ge v2, v4, :cond_1

    .line 296
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 298
    .local v0, "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v4, "phase"

    aget-object v5, v1, v2

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 300
    iget v4, p1, Lcom/adobe/air/wand/view/GestureEventData;->mType:I

    packed-switch v4, :pswitch_data_0

    .line 318
    :goto_1
    const-string v4, "isTransform"

    iget-boolean v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mIsTransform:Z

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 319
    const-string v4, "localX"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mXCoord:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 320
    const-string v4, "localY"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mYCoord:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 321
    const-string v4, "scaleX"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mScaleX:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 322
    const-string v4, "scaleY"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mScaleY:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 323
    const-string v4, "rotation"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mRotation:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 324
    const-string v4, "offsetX"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetX:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 325
    const-string v4, "offsetY"

    iget v5, p1, Lcom/adobe/air/wand/view/GestureEventData;->mOffsetY:F

    float-to-double v6, v5

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 326
    const-string v4, "timestamp"

    new-instance v5, Ljava/util/Date;

    invoke-direct {v5}, Ljava/util/Date;-><init>()V

    invoke-virtual {v5}, Ljava/util/Date;->getTime()J

    move-result-wide v6

    invoke-interface {v0, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;J)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 328
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    sget-object v5, Lcom/adobe/air/wand/TaskManager$MessageTitle;->GESTURE_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v5}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v0}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;

    move-result-object v3

    .line 330
    .local v3, "serializedNotification":Ljava/lang/String;
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v4, v3}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V

    .line 292
    .end local v0    # "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v3    # "serializedNotification":Ljava/lang/String;
    :cond_0
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 302
    .restart local v0    # "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    :pswitch_0
    const-string v4, "type"

    const-string v5, "GESTURE_PAN"

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    goto :goto_1

    .line 332
    .end local v0    # "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    :catch_0
    move-exception v4

    goto :goto_2

    .line 305
    .restart local v0    # "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    :pswitch_1
    const-string v4, "type"

    const-string v5, "GESTURE_ROTATE"

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    goto :goto_1

    .line 308
    :pswitch_2
    const-string v4, "type"

    const-string v5, "GESTURE_SWIPE"

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    goto :goto_1

    .line 311
    :pswitch_3
    const-string v4, "type"

    const-string v5, "GESTURE_TWO_FINGER_TAP"

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    goto/16 :goto_1

    .line 314
    :pswitch_4
    const-string v4, "type"

    const-string v5, "GESTURE_ZOOM"

    invoke-interface {v0, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto/16 :goto_1

    .line 338
    .end local v0    # "gesture":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_1
    return-void

    .line 300
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_0
        :pswitch_1
        :pswitch_3
        :pswitch_2
    .end packed-switch
.end method

.method private sendLogNotification(Ljava/lang/String;)V
    .locals 4
    .param p1, "logMessage"    # Ljava/lang/String;

    .prologue
    .line 440
    if-eqz p1, :cond_0

    const-string v2, ""

    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 455
    :cond_0
    :goto_0
    return-void

    .line 442
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v2}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 445
    .local v0, "logMessageObject":Lcom/adobe/air/wand/message/MessageDataObject;
    :try_start_0
    const-string v2, "message"

    invoke-interface {v0, v2, p1}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 447
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    sget-object v3, Lcom/adobe/air/wand/TaskManager$MessageTitle;->ERROR_LOG:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v3}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;

    move-result-object v1

    .line 449
    .local v1, "serializedResponse":Ljava/lang/String;
    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v2, v1}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 451
    .end local v1    # "serializedResponse":Ljava/lang/String;
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private sendMotionSensorData([FJLjava/lang/String;Lcom/adobe/air/wand/TaskManager$MessageTitle;)V
    .locals 10
    .param p1, "values"    # [F
    .param p2, "timestamp"    # J
    .param p4, "sensorDataFieldName"    # Ljava/lang/String;
    .param p5, "sensorTitle"    # Lcom/adobe/air/wand/TaskManager$MessageTitle;

    .prologue
    .line 397
    :try_start_0
    iget-object v6, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v6}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v0

    .line 399
    .local v0, "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v8

    sub-long v4, v6, v8

    .line 401
    .local v4, "timeDiff":J
    iget-object v6, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v6}, Lcom/adobe/air/wand/message/MessageManager;->createDataArray()Lcom/adobe/air/wand/message/MessageDataArray;

    move-result-object v1

    .line 403
    .local v1, "sensorValues":Lcom/adobe/air/wand/message/MessageDataArray;
    const/4 v3, 0x0

    .line 405
    .local v3, "valueItr":I
    :goto_0
    array-length v6, p1

    if-ge v3, v6, :cond_0

    .line 407
    aget v6, p1, v3

    float-to-double v6, v6

    invoke-interface {v1, v3, v6, v7}, Lcom/adobe/air/wand/message/MessageDataArray;->put(ID)Lcom/adobe/air/wand/message/MessageDataArray;

    .line 405
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 410
    :cond_0
    const-wide/32 v6, 0xf4240

    div-long v6, p2, v6

    add-long/2addr v6, v4

    invoke-interface {v1, v3, v6, v7}, Lcom/adobe/air/wand/message/MessageDataArray;->put(IJ)Lcom/adobe/air/wand/message/MessageDataArray;

    .line 412
    invoke-interface {v0, p4, v1}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataArray;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 414
    iget-object v6, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {p5}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7, v0}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;

    move-result-object v2

    .line 416
    .local v2, "serializedNotification":Ljava/lang/String;
    iget-object v6, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v6, :cond_1

    iget-object v6, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v6, v2}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 422
    .end local v0    # "notificationData":Lcom/adobe/air/wand/message/MessageDataObject;
    .end local v1    # "sensorValues":Lcom/adobe/air/wand/message/MessageDataArray;
    .end local v2    # "serializedNotification":Ljava/lang/String;
    .end local v3    # "valueItr":I
    .end local v4    # "timeDiff":J
    :cond_1
    :goto_1
    return-void

    .line 418
    :catch_0
    move-exception v6

    goto :goto_1
.end method

.method private sendTouchEventData(Lcom/adobe/air/TouchEventData;)V
    .locals 8
    .param p1, "touchEvent"    # Lcom/adobe/air/TouchEventData;

    .prologue
    .line 364
    iget v4, p1, Lcom/adobe/air/TouchEventData;->mTouchEventType:I

    invoke-direct {p0, v4}, Lcom/adobe/air/wand/TaskManager;->getTouchTypes(I)[Ljava/lang/String;

    move-result-object v3

    .line 366
    .local v3, "touchTypes":[Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v4, v3

    if-ge v0, v4, :cond_1

    .line 370
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/MessageManager;->createDataObject()Lcom/adobe/air/wand/message/MessageDataObject;

    move-result-object v2

    .line 372
    .local v2, "touch":Lcom/adobe/air/wand/message/MessageDataObject;
    const-string v4, "type"

    aget-object v5, v3, v0

    invoke-interface {v2, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 373
    const-string v4, "isPrimaryTouchPoint"

    iget-boolean v5, p1, Lcom/adobe/air/TouchEventData;->mIsPrimaryPoint:Z

    invoke-interface {v2, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;Z)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 374
    const-string v4, "localX"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mXCoord:F

    float-to-double v6, v5

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 375
    const-string v4, "localY"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mYCoord:F

    float-to-double v6, v5

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 376
    const-string v4, "pressure"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mPressure:F

    float-to-double v6, v5

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 377
    const-string v4, "sizeX"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mContactX:F

    float-to-double v6, v5

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 378
    const-string v4, "sizeY"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mContactY:F

    float-to-double v6, v5

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;D)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 379
    const-string v4, "touchPointID"

    iget v5, p1, Lcom/adobe/air/TouchEventData;->mPointerID:I

    invoke-interface {v2, v4, v5}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;I)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 380
    const-string v4, "timestamp"

    new-instance v5, Ljava/util/Date;

    invoke-direct {v5}, Ljava/util/Date;-><init>()V

    invoke-virtual {v5}, Ljava/util/Date;->getTime()J

    move-result-wide v6

    invoke-interface {v2, v4, v6, v7}, Lcom/adobe/air/wand/message/MessageDataObject;->put(Ljava/lang/String;J)Lcom/adobe/air/wand/message/MessageDataObject;

    .line 382
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    sget-object v5, Lcom/adobe/air/wand/TaskManager$MessageTitle;->TOUCH_EVENT:Lcom/adobe/air/wand/TaskManager$MessageTitle;

    invoke-virtual {v5}, Lcom/adobe/air/wand/TaskManager$MessageTitle;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5, v2}, Lcom/adobe/air/wand/message/MessageManager;->createSerializedNotification(Ljava/lang/String;Lcom/adobe/air/wand/message/MessageDataObject;)Ljava/lang/String;

    move-result-object v1

    .line 384
    .local v1, "serializedNotification":Ljava/lang/String;
    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    invoke-interface {v4, v1}, Lcom/adobe/air/wand/TaskManager$Listener;->sendConnectionMessage(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 366
    .end local v1    # "serializedNotification":Ljava/lang/String;
    .end local v2    # "touch":Lcom/adobe/air/wand/message/MessageDataObject;
    :cond_0
    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 392
    :cond_1
    return-void

    .line 386
    :catch_0
    move-exception v4

    goto :goto_1
.end method


# virtual methods
.method public handleRemoteMessage(Ljava/lang/String;)V
    .locals 5
    .param p1, "message"    # Ljava/lang/String;

    .prologue
    .line 460
    :try_start_0
    iget-object v3, p0, Lcom/adobe/air/wand/TaskManager;->mMessageManager:Lcom/adobe/air/wand/message/MessageManager;

    invoke-virtual {v3, p1}, Lcom/adobe/air/wand/message/MessageManager;->deserializeWandMessage(Ljava/lang/String;)Lcom/adobe/air/wand/message/Message;

    move-result-object v2

    .line 462
    .local v2, "wwMsg":Lcom/adobe/air/wand/message/Message;
    sget-object v3, Lcom/adobe/air/wand/TaskManager$5;->$SwitchMap$com$adobe$air$wand$message$Message$Type:[I

    invoke-virtual {v2}, Lcom/adobe/air/wand/message/Message;->getHeader()Lcom/adobe/air/wand/message/Message$Header;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/Message$Header;->getType()Lcom/adobe/air/wand/message/Message$Type;

    move-result-object v4

    invoke-virtual {v4}, Lcom/adobe/air/wand/message/Message$Type;->ordinal()I

    move-result v4

    aget v3, v3, v4

    packed-switch v3, :pswitch_data_0

    .line 484
    .end local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    :goto_0
    return-void

    .line 465
    .restart local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    :pswitch_0
    check-cast v2, Lcom/adobe/air/wand/message/Request;

    .end local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->handleRemoteRequest(Lcom/adobe/air/wand/message/Request;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 477
    :catch_0
    move-exception v0

    .line 479
    .local v0, "e":Ljava/lang/Exception;
    if-nez p1, :cond_0

    const-string v1, "null"

    .line 480
    .local v1, "m":Ljava/lang/String;
    :goto_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Invalid message : \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/adobe/air/wand/TaskManager;->sendLogNotification(Ljava/lang/String;)V

    goto :goto_0

    .line 469
    .end local v0    # "e":Ljava/lang/Exception;
    .end local v1    # "m":Ljava/lang/String;
    .restart local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    :pswitch_1
    :try_start_1
    check-cast v2, Lcom/adobe/air/wand/message/Response;

    .end local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->handleRemoteResponse(Lcom/adobe/air/wand/message/Response;)V

    goto :goto_0

    .line 473
    .restart local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    :pswitch_2
    check-cast v2, Lcom/adobe/air/wand/message/Notification;

    .end local v2    # "wwMsg":Lcom/adobe/air/wand/message/Message;
    invoke-direct {p0, v2}, Lcom/adobe/air/wand/TaskManager;->handleRemoteNotification(Lcom/adobe/air/wand/message/Notification;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    .restart local v0    # "e":Ljava/lang/Exception;
    :cond_0
    move-object v1, p1

    .line 479
    goto :goto_1

    .line 462
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
    .end packed-switch
.end method

.method public registerListener(Lcom/adobe/air/wand/TaskManager$Listener;)V
    .locals 2
    .param p1, "listener"    # Lcom/adobe/air/wand/TaskManager$Listener;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    .line 426
    if-nez p1, :cond_0

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "Invalid listener"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 428
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    if-eqz v0, :cond_1

    new-instance v0, Ljava/lang/Exception;

    const-string v1, "A listener is already registered"

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 430
    :cond_1
    iput-object p1, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    .line 431
    return-void
.end method

.method terminateRunningTasks()V
    .locals 1

    .prologue
    .line 553
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->active()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 555
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mAccelerometer:Lcom/adobe/air/wand/motionsensor/Accelerometer;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Accelerometer;->stop()V

    .line 558
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->active()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 560
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mMagnetometer:Lcom/adobe/air/wand/motionsensor/Magnetometer;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Magnetometer;->stop()V

    .line 563
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->active()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 565
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mGyroscope:Lcom/adobe/air/wand/motionsensor/Gyroscope;

    invoke-virtual {v0}, Lcom/adobe/air/wand/motionsensor/Gyroscope;->stop()V

    .line 568
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/TouchSensor;->activeTouchListening()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 570
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/TouchSensor;->stopTouchEventListening()V

    .line 573
    :cond_3
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/TouchSensor;->activeGestureListening()Z

    move-result v0

    if-eqz v0, :cond_4

    .line 575
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mTouchSensor:Lcom/adobe/air/wand/view/TouchSensor;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/TouchSensor;->stopGestureEventListening()V

    .line 578
    :cond_4
    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mVibrator:Landroid/os/Vibrator;

    invoke-virtual {v0}, Landroid/os/Vibrator;->cancel()V

    .line 579
    :cond_5
    return-void
.end method

.method public unregisterListener()V
    .locals 1

    .prologue
    .line 435
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/wand/TaskManager;->mListener:Lcom/adobe/air/wand/TaskManager$Listener;

    .line 436
    return-void
.end method
