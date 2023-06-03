.class Lcom/adobe/air/AIRWindowSurfaceView$2;
.super Ljava/lang/Object;
.source "AIRWindowSurfaceView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRWindowSurfaceView;->setSurfaceFormatImpl(ZI)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRWindowSurfaceView;

.field final synthetic val$format:I


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRWindowSurfaceView;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    .line 1071
    iput-object p1, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    iput p2, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->val$format:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 1073
    iget-object v0, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    iget-object v0, v0, Lcom/adobe/air/AIRWindowSurfaceView;->mSurfaceHolder:Landroid/view/SurfaceHolder;

    iget v1, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->val$format:I

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setFormat(I)V

    .line 1074
    iget-object v0, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    iget v1, p0, Lcom/adobe/air/AIRWindowSurfaceView$2;->val$format:I

    invoke-static {v0, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->access$802(Lcom/adobe/air/AIRWindowSurfaceView;I)I

    .line 1075
    return-void
.end method
