.class Lcom/adobe/flashruntime/shared/VideoView$2;
.super Ljava/lang/Object;
.source "VideoView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/flashruntime/shared/VideoView;->setPlanePosition(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/flashruntime/shared/VideoView;


# direct methods
.method constructor <init>(Lcom/adobe/flashruntime/shared/VideoView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/flashruntime/shared/VideoView;

    .prologue
    .line 133
    iput-object p1, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 136
    iget-object v0, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    iget-object v1, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v1}, Lcom/adobe/flashruntime/shared/VideoView;->access$200(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v1

    iget-object v2, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v2}, Lcom/adobe/flashruntime/shared/VideoView;->access$400(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v2

    iget-object v3, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v3}, Lcom/adobe/flashruntime/shared/VideoView;->access$100(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v3

    iget-object v4, p0, Lcom/adobe/flashruntime/shared/VideoView$2;->this$0:Lcom/adobe/flashruntime/shared/VideoView;

    invoke-static {v4}, Lcom/adobe/flashruntime/shared/VideoView;->access$300(Lcom/adobe/flashruntime/shared/VideoView;)I

    move-result v4

    invoke-virtual {v0, v1, v2, v3, v4}, Lcom/adobe/flashruntime/shared/VideoView;->layout(IIII)V

    .line 137
    return-void
.end method
