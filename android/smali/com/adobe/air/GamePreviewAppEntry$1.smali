.class Lcom/adobe/air/GamePreviewAppEntry$1;
.super Ljava/lang/Object;
.source "GamePreviewAppEntry.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/GamePreviewAppEntry;->showDialog(ILjava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/GamePreviewAppEntry;


# direct methods
.method constructor <init>(Lcom/adobe/air/GamePreviewAppEntry;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/GamePreviewAppEntry;

    .prologue
    .line 160
    iput-object p1, p0, Lcom/adobe/air/GamePreviewAppEntry$1;->this$0:Lcom/adobe/air/GamePreviewAppEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 163
    iget-object v0, p0, Lcom/adobe/air/GamePreviewAppEntry$1;->this$0:Lcom/adobe/air/GamePreviewAppEntry;

    invoke-static {v0}, Lcom/adobe/air/GamePreviewAppEntry;->access$000(Lcom/adobe/air/GamePreviewAppEntry;)V

    .line 164
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/System;->exit(I)V

    .line 165
    return-void
.end method
