.class public Lcom/adobe/air/AIRWindowThreadedSurfaceView;
.super Lcom/adobe/air/AIRWindowSurfaceView;
.source "AIRWindowThreadedSurfaceView.java"


# instance fields
.field public final drawSemaphore:Ljava/util/concurrent/Semaphore;

.field private thread:Lcom/adobe/air/DrawThread;


# direct methods
.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "aActivityWrapper"    # Lcom/adobe/air/AndroidActivityWrapper;

    .prologue
    .line 22
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AIRWindowSurfaceView;-><init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V

    .line 17
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    .line 18
    new-instance v0, Ljava/util/concurrent/Semaphore;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/Semaphore;-><init>(I)V

    iput-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->drawSemaphore:Ljava/util/concurrent/Semaphore;

    .line 23
    invoke-virtual {p0, p1}, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->Init(Landroid/content/Context;)V

    .line 24
    return-void
.end method


# virtual methods
.method protected Init(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 29
    new-instance v0, Lcom/adobe/air/DrawThread;

    iget-object v1, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->mSurfaceHolder:Landroid/view/SurfaceHolder;

    invoke-direct {v0, p0, v1, p1}, Lcom/adobe/air/DrawThread;-><init>(Lcom/adobe/air/AIRWindowThreadedSurfaceView;Landroid/view/SurfaceHolder;Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    .line 33
    return-void
.end method

.method public drawBitmap(IIIILandroid/graphics/Bitmap;)V
    .locals 6
    .param p1, "srcX"    # I
    .param p2, "srcY"    # I
    .param p3, "srcWd"    # I
    .param p4, "srcHt"    # I
    .param p5, "bm"    # Landroid/graphics/Bitmap;

    .prologue
    .line 93
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move-object v5, p5

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/DrawThread;->requestDraw(IIIILandroid/graphics/Bitmap;)V

    .line 103
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->drawSemaphore:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->acquire()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 109
    :goto_0
    return-void

    .line 105
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public drawBitmap(IIIILandroid/graphics/Bitmap;IIIIZI)V
    .locals 12
    .param p1, "srcX"    # I
    .param p2, "srcY"    # I
    .param p3, "srcWd"    # I
    .param p4, "srcHt"    # I
    .param p5, "bm"    # Landroid/graphics/Bitmap;
    .param p6, "dstX"    # I
    .param p7, "dstY"    # I
    .param p8, "dstWd"    # I
    .param p9, "dstHt"    # I
    .param p10, "fullsc"    # Z
    .param p11, "bgColor"    # I

    .prologue
    .line 114
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    move v1, p1

    move v2, p2

    move v3, p3

    move/from16 v4, p4

    move-object/from16 v5, p5

    move/from16 v6, p6

    move/from16 v7, p7

    move/from16 v8, p8

    move/from16 v9, p9

    move/from16 v10, p10

    move/from16 v11, p11

    invoke-virtual/range {v0 .. v11}, Lcom/adobe/air/DrawThread;->requestDraw(IIIILandroid/graphics/Bitmap;IIIIZI)V

    .line 117
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->drawSemaphore:Ljava/util/concurrent/Semaphore;

    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->acquire()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 123
    :goto_0
    return-void

    .line 119
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 0
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .prologue
    .line 60
    invoke-super {p0, p1, p2, p3, p4}, Lcom/adobe/air/AIRWindowSurfaceView;->surfaceChanged(Landroid/view/SurfaceHolder;III)V

    .line 61
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 38
    invoke-super {p0, p1}, Lcom/adobe/air/AIRWindowSurfaceView;->surfaceCreated(Landroid/view/SurfaceHolder;)V

    .line 43
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/adobe/air/DrawThread;->setRunning(Z)V

    .line 44
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    invoke-virtual {v0}, Lcom/adobe/air/DrawThread;->isAlive()Z

    move-result v0

    if-nez v0, :cond_0

    .line 48
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    invoke-virtual {v0}, Lcom/adobe/air/DrawThread;->start()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    :cond_0
    :goto_0
    return-void

    .line 50
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 3
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 66
    invoke-super {p0, p1}, Lcom/adobe/air/AIRWindowSurfaceView;->surfaceDestroyed(Landroid/view/SurfaceHolder;)V

    .line 72
    const/4 v0, 0x1

    .line 73
    .local v0, "retry":Z
    iget-object v1, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lcom/adobe/air/DrawThread;->setRunning(Z)V

    .line 75
    :goto_0
    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    invoke-virtual {v1}, Lcom/adobe/air/DrawThread;->isAlive()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 79
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/AIRWindowThreadedSurfaceView;->thread:Lcom/adobe/air/DrawThread;

    invoke-virtual {v1}, Lcom/adobe/air/DrawThread;->join()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 81
    const/4 v0, 0x0

    goto :goto_0

    .line 88
    :cond_0
    return-void

    .line 83
    :catch_0
    move-exception v1

    goto :goto_0
.end method
