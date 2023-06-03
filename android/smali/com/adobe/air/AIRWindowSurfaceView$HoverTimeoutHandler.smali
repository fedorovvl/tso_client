.class Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;
.super Landroid/os/Handler;
.source "AIRWindowSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRWindowSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "HoverTimeoutHandler"
.end annotation


# static fields
.field static final INTERVAL:I = 0x1f4


# instance fields
.field private mAIRWindowSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

.field private mLastMove:J

.field final synthetic this$0:Lcom/adobe/air/AIRWindowSurfaceView;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AIRWindowSurfaceView;Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRWindowSurfaceView;
    .param p2, "airWindowSurfaceView"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    .line 224
    iput-object p1, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 225
    iput-object p2, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mAIRWindowSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 226
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 12
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    const-wide/16 v10, 0x1f4

    const/4 v9, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    .line 230
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v6, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mLastMove:J

    sub-long/2addr v2, v6

    cmp-long v1, v2, v10

    if-ltz v1, :cond_0

    .line 232
    iget-object v1, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-static {v1, v5}, Lcom/adobe/air/AIRWindowSurfaceView;->access$002(Lcom/adobe/air/AIRWindowSurfaceView;Z)Z

    .line 233
    new-instance v0, Lcom/adobe/air/TouchEventData;

    const/16 v1, 0x20

    iget-object v2, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mAIRWindowSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 234
    invoke-static {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->access$100(Lcom/adobe/air/AIRWindowSurfaceView;)F

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mAIRWindowSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 235
    invoke-static {v3}, Lcom/adobe/air/AIRWindowSurfaceView;->access$200(Lcom/adobe/air/AIRWindowSurfaceView;)F

    move-result v3

    const/4 v8, 0x1

    iget-object v6, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mAIRWindowSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 242
    invoke-static {v6}, Lcom/adobe/air/AIRWindowSurfaceView;->access$300(Lcom/adobe/air/AIRWindowSurfaceView;)I

    move-result v10

    move v6, v4

    move v7, v4

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/TouchEventData;-><init>(IFFFIFFZ[FI)V

    .line 243
    .local v0, "touchEventData":Lcom/adobe/air/TouchEventData;
    invoke-static {v5, v0, v9}, Lcom/adobe/air/Entrypoints;->registerTouchCallback(ILcom/adobe/air/TouchEventData;Landroid/os/Handler;)Z

    .line 249
    .end local v0    # "touchEventData":Lcom/adobe/air/TouchEventData;
    :goto_0
    return-void

    .line 247
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-static {v1}, Lcom/adobe/air/AIRWindowSurfaceView;->access$400(Lcom/adobe/air/AIRWindowSurfaceView;)Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;

    move-result-object v1

    invoke-virtual {v1, v5, v10, v11}, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->sendEmptyMessageDelayed(IJ)Z

    goto :goto_0
.end method

.method public setLastMove(J)V
    .locals 1
    .param p1, "lastMove"    # J

    .prologue
    .line 251
    iput-wide p1, p0, Lcom/adobe/air/AIRWindowSurfaceView$HoverTimeoutHandler;->mLastMove:J

    return-void
.end method
