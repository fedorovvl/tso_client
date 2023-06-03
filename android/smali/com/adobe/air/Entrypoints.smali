.class public Lcom/adobe/air/Entrypoints;
.super Ljava/lang/Object;
.source "Entrypoints.java"


# static fields
.field static mCallEntryMain:Z

.field private static mLibCorePath:Ljava/lang/String;

.field private static mMainHandler:Lcom/adobe/air/customHandler;

.field public static s_context:Landroid/content/Context;

.field private static s_packageName:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 48
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/Entrypoints;->mLibCorePath:Ljava/lang/String;

    .line 52
    new-instance v0, Lcom/adobe/air/customHandler;

    invoke-direct {v0}, Lcom/adobe/air/customHandler;-><init>()V

    sput-object v0, Lcom/adobe/air/Entrypoints;->mMainHandler:Lcom/adobe/air/customHandler;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p0, "action"    # Ljava/lang/String;
    .param p1, "data"    # Ljava/lang/String;

    .prologue
    .line 123
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 124
    .local v0, "actWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    invoke-virtual {v0, p0, p1}, Lcom/adobe/air/AndroidActivityWrapper;->BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V

    .line 125
    return-void
.end method

.method public static getAppCacheDirectory()Ljava/lang/String;
    .locals 1

    .prologue
    .line 199
    sget-object v0, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static getMainHandler()Landroid/os/Handler;
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lcom/adobe/air/Entrypoints;->mMainHandler:Lcom/adobe/air/customHandler;

    return-object v0
.end method

.method public static getPackageName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 194
    sget-object v0, Lcom/adobe/air/Entrypoints;->s_packageName:Ljava/lang/String;

    return-object v0
.end method

.method public static getRuntimeDataDirectory()Ljava/lang/String;
    .locals 2

    .prologue
    .line 204
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static registerCallback(IIILandroid/os/Handler;)V
    .locals 4
    .param p0, "aTime"    # I
    .param p1, "low_id"    # I
    .param p2, "high_id"    # I
    .param p3, "handlerInstance"    # Landroid/os/Handler;

    .prologue
    .line 62
    if-nez p3, :cond_0

    .line 64
    sget-object p3, Lcom/adobe/air/Entrypoints;->mMainHandler:Lcom/adobe/air/customHandler;

    .line 67
    :cond_0
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 68
    .local v0, "msg":Landroid/os/Message;
    const/16 v1, 0x45f

    iput v1, v0, Landroid/os/Message;->what:I

    .line 69
    iput p1, v0, Landroid/os/Message;->arg1:I

    .line 70
    iput p2, v0, Landroid/os/Message;->arg2:I

    .line 72
    if-lez p0, :cond_1

    .line 73
    int-to-long v2, p0

    invoke-virtual {p3, v0, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 78
    :goto_0
    return-void

    .line 76
    :cond_1
    invoke-virtual {p3, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method public static registerKeyCallback(ILcom/adobe/air/KeyEventData;Landroid/os/Handler;)Z
    .locals 4
    .param p0, "delay"    # I
    .param p1, "keyObject"    # Lcom/adobe/air/KeyEventData;
    .param p2, "handlerInstance"    # Landroid/os/Handler;

    .prologue
    .line 102
    if-nez p2, :cond_0

    .line 104
    sget-object p2, Lcom/adobe/air/Entrypoints;->mMainHandler:Lcom/adobe/air/customHandler;

    .line 107
    :cond_0
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 108
    .local v0, "msg":Landroid/os/Message;
    const/16 v1, 0x461

    iput v1, v0, Landroid/os/Message;->what:I

    .line 110
    iput-object p1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 113
    if-lez p0, :cond_1

    .line 114
    int-to-long v2, p0

    invoke-virtual {p2, v0, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 118
    :goto_0
    const/4 v1, 0x1

    return v1

    .line 116
    :cond_1
    invoke-virtual {p2, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method

.method public static registerTouchCallback(ILcom/adobe/air/TouchEventData;Landroid/os/Handler;)Z
    .locals 4
    .param p0, "delay"    # I
    .param p1, "touchObject"    # Lcom/adobe/air/TouchEventData;
    .param p2, "handlerInstance"    # Landroid/os/Handler;

    .prologue
    .line 82
    if-nez p2, :cond_0

    .line 84
    sget-object p2, Lcom/adobe/air/Entrypoints;->mMainHandler:Lcom/adobe/air/customHandler;

    .line 87
    :cond_0
    invoke-static {}, Landroid/os/Message;->obtain()Landroid/os/Message;

    move-result-object v0

    .line 88
    .local v0, "msg":Landroid/os/Message;
    const/16 v1, 0x460

    iput v1, v0, Landroid/os/Message;->what:I

    .line 90
    iput-object p1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 92
    if-lez p0, :cond_1

    .line 93
    int-to-long v2, p0

    invoke-virtual {p2, v0, v2, v3}, Landroid/os/Handler;->sendMessageDelayed(Landroid/os/Message;J)Z

    .line 97
    :goto_0
    const/4 v1, 0x1

    return v1

    .line 95
    :cond_1
    invoke-virtual {p2, v0}, Landroid/os/Handler;->sendMessage(Landroid/os/Message;)Z

    goto :goto_0
.end method


# virtual methods
.method public EntryApplyDownloadedConfig()V
    .locals 0

    .prologue
    .line 178
    invoke-virtual {p0}, Lcom/adobe/air/Entrypoints;->applyDownloadedConfig()V

    .line 179
    return-void
.end method

.method public EntryDownloadConfig(Ljava/lang/Object;Ljava/lang/String;)Z
    .locals 3
    .param p1, "context"    # Ljava/lang/Object;
    .param p2, "runtimePackageName"    # Ljava/lang/String;

    .prologue
    .line 154
    move-object v2, p1

    check-cast v2, Landroid/content/Context;

    sput-object v2, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    .line 156
    sget-object v2, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 157
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v2, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    sput-object v2, Lcom/adobe/air/Entrypoints;->s_packageName:Ljava/lang/String;

    .line 159
    sget-object v2, Lcom/adobe/air/Entrypoints;->s_packageName:Ljava/lang/String;

    invoke-static {v2}, Lcom/adobe/air/ApplicationFileManager;->setAndroidPackageName(Ljava/lang/String;)V

    .line 162
    iget-object v2, v0, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    invoke-static {v2}, Lcom/adobe/air/ApplicationFileManager;->setAndroidAPKPath(Ljava/lang/String;)V

    .line 164
    sget-object v2, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v1

    .line 166
    .local v1, "cacheDir":Ljava/io/File;
    if-nez v1, :cond_0

    const/4 v2, 0x0

    .line 173
    :goto_0
    return v2

    .line 168
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/adobe/air/ApplicationFileManager;->processAndroidDataPath(Ljava/lang/String;)V

    .line 170
    sget-object v2, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-static {v2}, Lcom/adobe/air/utils/Utils;->GetLibSTLPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 171
    invoke-virtual {p0}, Lcom/adobe/air/Entrypoints;->GetLibCorePath()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 172
    invoke-virtual {p0, p1, p2}, Lcom/adobe/air/Entrypoints;->EntryDownloadConfigNative(Ljava/lang/Object;Ljava/lang/String;)V

    .line 173
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public native EntryDownloadConfigNative(Ljava/lang/Object;Ljava/lang/String;)V
.end method

.method public EntryMain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;ZZ)V
    .locals 12
    .param p1, "appXmlPath"    # Ljava/lang/String;
    .param p2, "appRootDir"    # Ljava/lang/String;
    .param p3, "extraArgs"    # Ljava/lang/String;
    .param p4, "runtimePackageName"    # Ljava/lang/String;
    .param p5, "mainView"    # Ljava/lang/Object;
    .param p6, "app"    # Ljava/lang/Object;
    .param p7, "appInfo"    # Ljava/lang/Object;
    .param p8, "context"    # Ljava/lang/Object;
    .param p9, "activityWrapper"    # Ljava/lang/Object;
    .param p10, "isADL"    # Z
    .param p11, "isDebuggerMode"    # Z

    .prologue
    .line 129
    move-object/from16 v1, p8

    check-cast v1, Landroid/content/Context;

    sput-object v1, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    .line 130
    check-cast p7, Landroid/content/pm/ApplicationInfo;

    .end local p7    # "appInfo":Ljava/lang/Object;
    move-object/from16 v0, p7

    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    sput-object v1, Lcom/adobe/air/Entrypoints;->s_packageName:Ljava/lang/String;

    .line 132
    sget-boolean v1, Lcom/adobe/air/Entrypoints;->mCallEntryMain:Z

    if-nez v1, :cond_0

    .line 134
    const/4 v1, 0x1

    sput-boolean v1, Lcom/adobe/air/Entrypoints;->mCallEntryMain:Z

    .line 137
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-lez v1, :cond_0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object/from16 v5, p4

    move-object/from16 v6, p5

    move-object/from16 v7, p6

    move-object/from16 v8, p8

    move-object/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    .line 139
    invoke-virtual/range {v1 .. v11}, Lcom/adobe/air/Entrypoints;->EntryMainWrapper(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;ZZ)V

    .line 142
    :cond_0
    return-void
.end method

.method public native EntryMainWrapper(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;ZZ)V
.end method

.method public EntryStopRuntime()V
    .locals 1

    .prologue
    .line 183
    invoke-virtual {p0}, Lcom/adobe/air/Entrypoints;->GetLibCorePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 184
    invoke-virtual {p0}, Lcom/adobe/air/Entrypoints;->EntryStopRuntimeNative()V

    .line 185
    return-void
.end method

.method public native EntryStopRuntimeNative()V
.end method

.method public GetLibCorePath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 146
    sget-object v0, Lcom/adobe/air/Entrypoints;->mLibCorePath:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 147
    sget-object v0, Lcom/adobe/air/Entrypoints;->s_context:Landroid/content/Context;

    invoke-static {v0}, Lcom/adobe/air/utils/Utils;->GetLibCorePath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/Entrypoints;->mLibCorePath:Ljava/lang/String;

    .line 149
    :cond_0
    sget-object v0, Lcom/adobe/air/Entrypoints;->mLibCorePath:Ljava/lang/String;

    return-object v0
.end method

.method public native applyDownloadedConfig()V
.end method

.method public setMainView(Landroid/view/View;)V
    .locals 0
    .param p1, "mainView"    # Landroid/view/View;

    .prologue
    .line 189
    check-cast p1, Lcom/adobe/air/AIRWindowSurfaceView;

    .end local p1    # "mainView":Landroid/view/View;
    invoke-virtual {p0, p1}, Lcom/adobe/air/Entrypoints;->setMainViewOnCreate(Lcom/adobe/air/AIRWindowSurfaceView;)V

    .line 190
    return-void
.end method

.method public native setMainViewOnCreate(Lcom/adobe/air/AIRWindowSurfaceView;)V
.end method
