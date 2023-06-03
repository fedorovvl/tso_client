.class Lcom/adobe/air/AIRStage3DSurfaceView$1;
.super Ljava/lang/Object;
.source "AIRStage3DSurfaceView.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRStage3DSurfaceView;->surfaceCreated(Landroid/view/SurfaceHolder;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRStage3DSurfaceView;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRStage3DSurfaceView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRStage3DSurfaceView;

    .prologue
    .line 135
    iput-object p1, p0, Lcom/adobe/air/AIRStage3DSurfaceView$1;->this$0:Lcom/adobe/air/AIRStage3DSurfaceView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 4

    .prologue
    .line 140
    iget-object v0, p0, Lcom/adobe/air/AIRStage3DSurfaceView$1;->this$0:Lcom/adobe/air/AIRStage3DSurfaceView;

    invoke-static {v0}, Lcom/adobe/air/AIRStage3DSurfaceView;->access$000(Lcom/adobe/air/AIRStage3DSurfaceView;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-eqz v0, :cond_0

    .line 143
    iget-object v0, p0, Lcom/adobe/air/AIRStage3DSurfaceView$1;->this$0:Lcom/adobe/air/AIRStage3DSurfaceView;

    iget-object v1, p0, Lcom/adobe/air/AIRStage3DSurfaceView$1;->this$0:Lcom/adobe/air/AIRStage3DSurfaceView;

    invoke-static {v1}, Lcom/adobe/air/AIRStage3DSurfaceView;->access$000(Lcom/adobe/air/AIRStage3DSurfaceView;)J

    move-result-wide v2

    invoke-static {v0, v2, v3}, Lcom/adobe/air/AIRStage3DSurfaceView;->access$100(Lcom/adobe/air/AIRStage3DSurfaceView;J)V

    .line 145
    :cond_0
    return-void
.end method
