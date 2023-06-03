.class Lcom/adobe/air/AIRWindowSurfaceView$MenuHandler;
.super Ljava/lang/Object;
.source "AIRWindowSurfaceView.java"

# interfaces
.implements Landroid/view/MenuItem$OnMenuItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRWindowSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "MenuHandler"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRWindowSurfaceView;


# direct methods
.method private constructor <init>(Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 0

    .prologue
    .line 1758
    iput-object p1, p0, Lcom/adobe/air/AIRWindowSurfaceView$MenuHandler;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/AIRWindowSurfaceView;Lcom/adobe/air/AIRWindowSurfaceView$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/AIRWindowSurfaceView;
    .param p2, "x1"    # Lcom/adobe/air/AIRWindowSurfaceView$1;

    .prologue
    .line 1758
    invoke-direct {p0, p1}, Lcom/adobe/air/AIRWindowSurfaceView$MenuHandler;-><init>(Lcom/adobe/air/AIRWindowSurfaceView;)V

    return-void
.end method


# virtual methods
.method public onMenuItemClick(Landroid/view/MenuItem;)Z
    .locals 2
    .param p1, "item"    # Landroid/view/MenuItem;

    .prologue
    .line 1762
    iget-object v0, p0, Lcom/adobe/air/AIRWindowSurfaceView$MenuHandler;->this$0:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/adobe/air/AIRWindowSurfaceView;->onTextBoxContextMenuItem(I)Z

    move-result v0

    return v0
.end method
