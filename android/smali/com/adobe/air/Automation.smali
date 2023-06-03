.class public Lcom/adobe/air/Automation;
.super Ljava/lang/Object;
.source "Automation.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public dispatchKeyEvent(Lcom/adobe/air/AIRWindowSurfaceView;IIIZZZ)Z
    .locals 10
    .param p1, "v"    # Lcom/adobe/air/AIRWindowSurfaceView;
    .param p2, "inKeyAction"    # I
    .param p3, "inKeyCode"    # I
    .param p4, "unicode"    # I
    .param p5, "alt"    # Z
    .param p6, "shift"    # Z
    .param p7, "sym"    # Z

    .prologue
    .line 38
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x9

    if-ge v2, v3, :cond_0

    .line 39
    const/4 v2, 0x0

    .line 63
    :goto_0
    return v2

    .line 43
    :cond_0
    const/4 v9, 0x0

    .line 44
    .local v9, "metastate":I
    if-eqz p5, :cond_1

    or-int/lit8 v9, v9, 0x2

    .line 45
    :cond_1
    if-eqz p6, :cond_2

    or-int/lit8 v9, v9, 0x1

    .line 46
    :cond_2
    if-eqz p7, :cond_3

    or-int/lit8 v9, v9, 0x4

    .line 48
    :cond_3
    :try_start_0
    new-instance v1, Landroid/view/KeyEvent;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v4

    const/4 v8, 0x0

    move v6, p2

    move v7, p3

    invoke-direct/range {v1 .. v9}, Landroid/view/KeyEvent;-><init>(JJIIII)V

    .line 49
    .local v1, "event":Landroid/view/KeyEvent;
    if-nez p2, :cond_5

    .line 51
    invoke-virtual {p1, p3, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->onKeyDown(ILandroid/view/KeyEvent;)Z

    .line 63
    .end local v1    # "event":Landroid/view/KeyEvent;
    :cond_4
    :goto_1
    const/4 v2, 0x1

    goto :goto_0

    .line 53
    .restart local v1    # "event":Landroid/view/KeyEvent;
    :cond_5
    const/4 v2, 0x1

    if-ne p2, v2, :cond_4

    .line 55
    invoke-virtual {p1, p3, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->onKeyUp(ILandroid/view/KeyEvent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 58
    .end local v1    # "event":Landroid/view/KeyEvent;
    :catch_0
    move-exception v0

    .line 60
    .local v0, "e":Ljava/lang/Exception;
    const-string v2, "Automation"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[JP] dispatchKeyEvent caught "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/adobe/air/utils/AIRLogger;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public dispatchTouchEvent(Lcom/adobe/air/AIRWindowSurfaceView;IFFFIFFZ[FI)Z
    .locals 10
    .param p1, "v"    # Lcom/adobe/air/AIRWindowSurfaceView;
    .param p2, "touchType"    # I
    .param p3, "x"    # F
    .param p4, "y"    # F
    .param p5, "pressure"    # F
    .param p6, "pointerid"    # I
    .param p7, "contactX"    # F
    .param p8, "contactY"    # F
    .param p9, "primaryPoint"    # Z
    .param p10, "history"    # [F
    .param p11, "metaState"    # I

    .prologue
    .line 20
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x9

    if-ge v0, v1, :cond_0

    .line 21
    const/4 v0, 0x0

    .line 33
    :goto_0
    return v0

    .line 25
    :cond_0
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    move v4, p2

    move v5, p3

    move v6, p4

    move/from16 v7, p11

    invoke-static/range {v0 .. v7}, Landroid/view/MotionEvent;->obtain(JJIFFI)Landroid/view/MotionEvent;

    move-result-object v9

    .line 26
    .local v9, "event":Landroid/view/MotionEvent;
    invoke-virtual {p1, v9}, Lcom/adobe/air/AIRWindowSurfaceView;->onTouchEvent(Landroid/view/MotionEvent;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 33
    .end local v9    # "event":Landroid/view/MotionEvent;
    :goto_1
    const/4 v0, 0x1

    goto :goto_0

    .line 28
    :catch_0
    move-exception v8

    .line 30
    .local v8, "e":Ljava/lang/Exception;
    const-string v0, "Automation"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[JP] dispatchTouchEvent caught "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/adobe/air/utils/AIRLogger;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method
